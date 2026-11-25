import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type, x-supabase-client-platform, x-supabase-client-platform-version, x-supabase-client-runtime, x-supabase-client-runtime-version",
};

interface ConversationMessage {
  message: string;
  direction: string;
  created_at: string;
  message_type?: string;
  metadata?: any;
}

serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const lovableApiKey = Deno.env.get("LOVABLE_API_KEY");
    const delegatesAi = !!(Deno.env.get("AI_GENERATE_URL") && Deno.env.get("BOT_API_KEY"));
    if (!lovableApiKey && !delegatesAi) {
      throw new Error("Neither LOVABLE_API_KEY nor AI_GENERATE_URL/BOT_API_KEY configured");
    }

    const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
    const supabaseServiceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
    const dbSchema = (Deno.env.get("DB_SCHEMA") || "ibbagamuwa_customization").toLowerCase();
    const supabase = createClient(supabaseUrl, supabaseServiceKey, {
      db: { schema: dbSchema },
      auth: { persistSession: false },
    });

    const { message, phoneNumber, conversationHistory, userId, sessionApiKey, senderName } = await req.json();

    console.log(`Processing AI chat for ${phoneNumber} (user: ${userId}): ${message}`);

    // Fetch products, FAQs, settings, profile, platform limits, and prior sent media metadata
    const [productsRes, faqsRes, settingsRes, profileRes, platformLimitsRes, priorOutboundRes] = await Promise.all([
      supabase.from("products").select("*").eq("is_active", true).eq("user_id", userId).order("price", { ascending: true }),
      supabase.from("faqs").select("*, products(name)").eq("is_active", true).eq("user_id", userId),
      supabase.from("settings").select("key, value").eq("user_id", userId),
      supabase.from("profiles").select("plan_tier, billing_cycle_start, is_paused, addon_contacts, addon_orders").eq("user_id", userId).single(),
      supabase.from("platform_settings").select("value").eq("key", "plan_limits").single(),
      supabase
        .from("conversations")
        .select("message, created_at, message_type, metadata")
        .eq("user_id", userId)
        .eq("phone_number", phoneNumber || "")
        .eq("direction", "outbound")
        .order("created_at", { ascending: false })
        .limit(200),
    ]);

    const alreadySentImages = new Set<string>();
    const alreadySentFaqMedia = new Set<string>();
    const outboundImageSignatures = new Set<string>();
    for (const row of priorOutboundRes.data || []) {
      const meta = (row as any)?.metadata;
      const sentImgs = meta?.sentImages || meta?.imageUrls;
      const hasImgs = (row as any)?.message_type === "image" || (Array.isArray(sentImgs) && sentImgs.length > 0);
      if (hasImgs && (row as any)?.message) {
        outboundImageSignatures.add(String((row as any).message).trim());
      }
      if (Array.isArray(sentImgs)) {
        for (const u of sentImgs) {
          if (typeof u === "string" && u.trim()) alreadySentImages.add(u.trim());
        }
      }
      const sentFaq = meta?.faqMedia;
      if (Array.isArray(sentFaq)) {
        for (const u of sentFaq) {
          if (typeof u === "string" && u.trim()) alreadySentFaqMedia.add(u.trim());
        }
      }
    }

    // Check if account is paused
    if (profileRes.data?.is_paused) {
      console.log(`Account paused for user ${userId}`);
      return new Response(
        JSON.stringify({ error: "Account paused", response: "Sorry, this business account is currently paused. Please try again later." }),
        { status: 403, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    const planTier = profileRes.data?.plan_tier || "free";
    const allLimits = platformLimitsRes.data?.value || {};
    const tierLimits = allLimits[planTier] || {};
    const contactLimit = (tierLimits.contacts_per_month || 50) + (profileRes.data?.addon_contacts || 0);

    // Use billing cycle start for monthly count
    const billingStart = profileRes.data?.billing_cycle_start;
    let monthStart: string;
    if (billingStart) {
      const start = new Date(billingStart);
      const now = new Date();
      const current = new Date(start);
      while (true) {
        const next = new Date(current);
        next.setMonth(next.getMonth() + 1);
        if (next > now) break;
        current.setMonth(current.getMonth() + 1);
      }
      monthStart = current.toISOString();
    } else {
      const d = new Date();
      d.setDate(1);
      d.setHours(0, 0, 0, 0);
      monthStart = d.toISOString();
    }

    // Contact-based billing: only NEW contacts are blocked once allowance is used up
    const contactKey = String(phoneNumber || "").split("@")[0].replace(/\D/g, "");
    const { data: alreadyCounted } = await supabase
      .from("contact_usage")
      .select("id")
      .eq("user_id", userId)
      .eq("phone_number", contactKey)
      .gte("created_at", monthStart)
      .maybeSingle();

    const { data: contactsUsed } = await supabase.rpc("get_contact_usage", {
      _user_id: userId,
      _since: monthStart,
    });

    // Also check orders limit
    const ordersLimit = (tierLimits.max_orders_per_month || 50) + (profileRes.data?.addon_orders || 0);
    const { count: ordersCount } = await supabase
      .from("orders")
      .select("id", { count: "exact", head: true })
      .eq("user_id", userId)
      .gte("created_at", monthStart);

    if (!alreadyCounted && (contactsUsed || 0) >= contactLimit) {
      console.log(`Contact limit reached for user ${userId}: ${contactsUsed}/${contactLimit}`);
      return new Response(
        JSON.stringify({ error: "Monthly contact limit reached. Please upgrade your plan.", response: "Sorry, the monthly contact limit has been reached. Please contact the business owner." }),
        { status: 429, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    const ordersLimitReached = (ordersCount || 0) >= ordersLimit;

    const products = productsRes.data || [];
    const faqs = faqsRes.data || [];
    const settings = settingsRes.data || [];

    const welcomeMessage = settings.find(s => s.key === "welcome_message")?.value?.text || "Welcome! How can I help you?";
    const paymentInfo = settings.find(s => s.key === "payment_info")?.value || {};
    const deliverySettings = settings.find(s => s.key === "delivery_settings")?.value || {};
    const freeDeliveryThreshold = deliverySettings.free_delivery_threshold || 0;

    // Index products by ID and lowercase name for fast media resolution
    const productById = new Map<string, any>();
    const productByName = new Map<string, any>();
    for (const p of products) {
      if (p.id) productById.set(p.id, p);
      if (p.name) productByName.set(p.name.toLowerCase(), p);
    }

    // Build catalog without raw image URLs (media is resolved via <PRODUCT_MEDIA> tags)
    const productCatalog = products.map(p => {
      let line = `- [ID: ${p.id}] ${p.name}: Base price LKR ${p.price} (${p.product_type})`;
      if (p.product_type === "physical" && p.delivery_price && p.delivery_price > 0) {
        line += ` | Delivery fee: LKR ${p.delivery_price}`;
      }
      if (p.description) line += ` - ${p.description}`;
      if (p.video_url) {
        line += ` | Video: ${p.video_url}`;
      }
      if (p.variations && Array.isArray(p.variations) && p.variations.length > 0) {
        const varLines = p.variations.map((v: any) => {
          const opts = v.options?.map((o: any) => {
            if (typeof o !== "object") return o;
            let optStr = `${o.label}: LKR ${o.price}`;
            if (o.subVariants && Array.isArray(o.subVariants) && o.subVariants.length > 0) {
              const subLines = o.subVariants.map((sv: any) => {
                const reqTag = sv.required ? " (REQUIRED)" : " (optional)";
                const subOpts = sv.options?.map((so: any) =>
                  typeof so === "object" ? `${so.label}: +LKR ${so.price}` : so
                ).join(", ");
                return `[${sv.name}${reqTag}: ${subOpts}]`;
              }).join(" ");
              optStr += ` ${subLines}`;
            }
            return optStr;
          }).join(", ");
          return `${v.name}: ${opts}`;
        }).join("; ");
        line += ` | Variations: ${varLines}`;
      }
      return line;
    }).join("\n");

    // Build product media lists and unambiguous base names for fast media resolution
    const productVideoMap: Record<string, string> = {};
    const productsWithImages: Array<{ id: string; name: string; baseName: string; images: string[] }> = [];
    const productsWithoutImages: Array<{ name: string; baseName: string }> = [];
    const baseNameCounts: Record<string, number> = {};
    const allBaseNameCounts: Record<string, number> = {};
    for (const p of products) {
      const baseName = p.name.replace(/\s*\([^)]*\)/g, "").trim().toLowerCase();
      allBaseNameCounts[baseName] = (allBaseNameCounts[baseName] || 0) + 1;
      const cleanImgs = Array.isArray(p.images)
        ? p.images.map((u: any) => String(u || "").trim()).filter(Boolean)
        : [];
      if (cleanImgs.length > 0) {
        baseNameCounts[baseName] = (baseNameCounts[baseName] || 0) + 1;
        productsWithImages.push({
          id: p.id,
          name: p.name.toLowerCase(),
          baseName,
          images: cleanImgs,
        });
      } else {
        productsWithoutImages.push({
          name: p.name.toLowerCase(),
          baseName,
        });
      }
      if (p.video_url) {
        productVideoMap[p.name.toLowerCase()] = p.video_url;
      }
    }

    // Build FAQ context with IDs so AI can report which ones it used
    const faqContext = faqs.map(f =>
      `[FAQ_ID:${f.id}] Q: ${f.question}\nA: ${f.answer}${f.products?.name ? ` (Related to: ${f.products.name})` : ""}`
    ).join("\n\n");
    const trackedFaqIds = faqs.filter((f: any) => f.is_tracked).map((f: any) => f.id);
    const fullySentProductNames = products
      .filter((p: any) => {
        const imgs = Array.isArray(p.images) ? p.images.map((u: any) => String(u || "").trim()).filter(Boolean) : [];
        return imgs.length > 0 && imgs.every((u: string) => alreadySentImages.has(u));
      })
      .map((p: any) => p.name);
    const previewSentProductNames = products
      .filter((p: any) => {
        const imgs = Array.isArray(p.images) ? p.images.map((u: any) => String(u || "").trim()).filter(Boolean) : [];
        return imgs.length > 1 && imgs.some((u: string) => alreadySentImages.has(u)) && imgs.some((u: string) => !alreadySentImages.has(u));
      })
      .map((p: any) => p.name);

    const systemPrompt = `You are the WhatsApp assistant for Ibbagamuwa Fishing Center.
Help customers with products, answering questions, and taking orders.

CRITICAL INSTRUCTIONS:
1. LANGUAGE: Always respond in the EXACT language used by the customer (Sinhala, English, or Tamil). Auto-detect dynamically.
2. CONCISE: WhatsApp messages must be short and scannable (2-4 lines). Write plain text only (NO asterisks *, NO bold, NO italics). Use emojis cleanly as bullet points (🔹, 📦, 💰, 🚚).
3. PRICE INTEGRITY: Base answers strictly on the catalog. All prices and delivery fees are fixed. Politely decline any discounts or custom deals.
4. PHOTOS:
   - NEVER send photos on generic greetings (e.g. "Hi", "Hello", "ආයුබෝවන්", "வணக்கம்").
   - When introducing or discussing a product, append <PRODUCT_MEDIA>exact_product_name</PRODUCT_MEDIA> at the very END.
   - Photos already sent: ${fullySentProductNames.length > 0 ? fullySentProductNames.join(", ") : "None"}. Do not resend unless explicitly requested.
5. ORDERING (STRICT 2-STEP CONFIRMATION):
   - Collect: Name, Phone, Delivery Address & City (or Email for digital items), Product & required Variation/Length/Size, Quantity, and Payment Method (COD or Bank Transfer).
   - STEP 1 (Review Summary): Once all details are collected, send a clear order summary with emojis (📦 Items, 💰 Subtotal, 🚚 Delivery, Total, 👤 Name, 📱 Phone, 📍 Address, 💳 Payment). Ask the customer to review and confirm if correct. STRICT: DO NOT append <ORDER_JSON> in Step 1!
   - STEP 2 (Confirmation): ONLY after the customer explicitly confirms the summary ("yes", "ok", "confirm", "හරි", "ඔව්", "சரி", "உறுதி"), send the confirmation message AND you MUST append at the very END:
   <ORDER_JSON>{"customer_name":"...","customer_phone":"...","district":"...","customer_address":"...","order_items":[{"name":"exact catalog name","price":0,"quantity":1,"variations":{},"product_type":"physical"}],"payment_method":"cod or bank_transfer","total_amount":0}</ORDER_JSON>
   Total amount must equal product price (+ variation additions) + delivery fee.
6. INVISIBLE TAGS: System tags (<ORDER_JSON>, <PRODUCT_MEDIA>, <VIDEO_URL>, <USED_FAQS>) must NEVER be shown to the customer. Put them only once at the very end of your response.

PRODUCT CATALOG:
${productCatalog || "No products available"}

FREQUENTLY ASKED QUESTIONS:
${faqContext || "No FAQs configured"}

PAYMENT ACCOUNTS:
${(() => {
        const accounts = paymentInfo.accounts;
        if (accounts && Array.isArray(accounts) && accounts.length > 0) {
          return accounts.map((a: any, i: number) => {
            const label = a.account_label || a.bank_name || "Bank";
            const number = a.account_number || "";
            const name = a.account_name || "";
            return `🔹 ${label} | Account: ${number} | Name: ${name}`;
          }).join("\n");
        }
        return `🔹 Bank: ${paymentInfo.bank_name || "Not configured"} | Account: ${paymentInfo.account_number || ""} | Name: ${paymentInfo.account_name || ""}`;
      })()}`;

    const messages = [
      { role: "system", content: systemPrompt },
    ];

    const trimmedMessage = (message || "").trim();
    const normalizedInput = trimmedMessage || "[Customer sent a photo/media file. This is likely a payment slip or receipt. Acknowledge it politely and ask them to confirm if it's a payment confirmation. Do NOT output any JSON, tags, or code.]";

    // Deduplicate: If conversationHistory already includes the current incoming message as its last item,
    // strip it so conversationHistory only contains prior turns, preventing duplication to the model.
    const sanitizedHistory: ConversationMessage[] = Array.isArray(conversationHistory) ? [...conversationHistory] : [];
    if (sanitizedHistory.length > 0) {
      const lastMsg = sanitizedHistory[sanitizedHistory.length - 1];
      if (lastMsg.direction === "inbound" && (lastMsg.message?.trim() === trimmedMessage || (trimmedMessage && lastMsg.message?.trim().toLowerCase() === trimmedMessage.toLowerCase()))) {
        sanitizedHistory.pop();
      }
    }

    for (const msg of sanitizedHistory) {
      const hasImages =
        msg.message_type === "image" ||
        (msg.metadata?.sentImages && Array.isArray(msg.metadata.sentImages) && msg.metadata.sentImages.length > 0) ||
        (msg.metadata?.imageUrls && Array.isArray(msg.metadata.imageUrls) && msg.metadata.imageUrls.length > 0) ||
        (msg.direction === "outbound" && outboundImageSignatures.has((msg.message || "").trim()));
      const content = (msg.direction === "outbound" && hasImages)
        ? `${msg.message}\n📷 [Product Photos Sent]`
        : msg.message;
      messages.push({
        role: msg.direction === "inbound" ? "user" : "assistant",
        content,
      });
    }

    messages.push({ role: "user", content: normalizedInput });

    const aiGenerateUrl = Deno.env.get("AI_GENERATE_URL");
    const botApiKey = Deno.env.get("BOT_API_KEY");
    const MODEL = "google/gemini-3-flash-preview";
    const MAX_TOKENS = 1200;

    let aiResponse: Response;
    if (aiGenerateUrl && botApiKey) {
      aiResponse = await fetch(aiGenerateUrl, {
        method: "POST",
        headers: { "Content-Type": "application/json", "x-bot-key": botApiKey },
        body: JSON.stringify({
          messages,
          model: MODEL,
          maxTokens: MAX_TOKENS,
        }),
      });
    } else {
      aiResponse = await fetch("https://ai.gateway.lovable.dev/v1/chat/completions", {
        method: "POST",
        headers: {
          Authorization: `Bearer ${lovableApiKey}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ model: MODEL, messages, max_tokens: MAX_TOKENS }),
      });
    }

    if (!aiResponse.ok) {
      if (aiResponse.status === 429) {
        return new Response(
          JSON.stringify({ error: "Rate limit exceeded. Please try again later." }),
          { status: 429, headers: { ...corsHeaders, "Content-Type": "application/json" } }
        );
      }
      if (aiResponse.status === 402) {
        return new Response(
          JSON.stringify({ error: "AI credits exhausted. Please add more credits." }),
          { status: 402, headers: { ...corsHeaders, "Content-Type": "application/json" } }
        );
      }
      const errorText = await aiResponse.text();
      console.error("AI Gateway error:", aiResponse.status, errorText);
      throw new Error("AI processing failed");
    }

    const aiData = await aiResponse.json();
    const responseText =
      aiData.text ||
      aiData.choices?.[0]?.message?.content ||
      "I'm sorry, I couldn't process your request. Please try again.";

    console.log(`AI Response: ${responseText.substring(0, 100)}...`);

    // Extract used FAQ IDs and log tracked ones
    const usedFaqsMatch = responseText.match(/<USED_FAQS>([\s\S]*?)<\/USED_FAQS>/);
    const usedFaqIds = usedFaqsMatch
      ? [...new Set(usedFaqsMatch[1].split(",").map((id: string) => id.trim()).filter((id: string) => id.length > 0))]
      : [];

    if (usedFaqIds.length > 0 && trackedFaqIds.length > 0) {
      const trackedUsedIds = usedFaqIds.filter((id: string) => trackedFaqIds.includes(id));
      if (trackedUsedIds.length > 0) {
        console.log(`Tracked FAQs used: ${trackedUsedIds.join(", ")} for phone ${phoneNumber}`);
        const usageLogs = trackedUsedIds.map((faqId: string) => ({
          faq_id: faqId,
          user_id: userId,
          phone_number: phoneNumber,
          sender_name: senderName || "Unknown",
        }));
        supabase.from("faq_usage_logs").insert(usageLogs).then(({ error }: any) => {
          if (error) console.error("Error logging FAQ usage:", error);
          else console.log(`Tracked FAQ hit logged for FAQs: ${trackedUsedIds.join(", ")}`);
        });
      }
    }

    // Check if the AI response contains order JSON
    let orderCreated = false;
    let hallucinatedOrderDetected = false;
    const customerInboundText = [
      ...sanitizedHistory
        .filter((m) => m.direction === "inbound")
        .map((m) => m.message || ""),
      trimmedMessage,
    ].join(" ").toLowerCase();

    // Guard against premature order creation during Order Summary review step
    const isAwaitingVerification = /(?:මේ විස්තර හරිද|වෙනස් කරන්න ඕන|හරිද කියලා බලන්න|විස්තර බලලා|තහවුරු කිරීමට පෙර|පරීක්ෂා කරන්න|check if these details are correct|are these details correct|is this correct|please confirm|சரிபார்க்கவும்|சரியா|உறுதிப்படுத்த)/i.test(responseText);
    const isExplicitConfirmation = /(?:හරි|confirm|ඔව්|yes|ok|okay|හරියි|right|correct|sure|done|දාන්න|ඇණවුම දාන්න|orders?|ஆம்|சரி|உறுதி)/i.test(trimmedMessage);

    // Orders strictly parsed from AI-emitted <ORDER_JSON> tags (no regex fallbacks)
    const orderJsonMatches = [...responseText.matchAll(/<ORDER_JSON>([\s\S]*?)<\/ORDER_JSON>/g)];

    for (const orderJsonMatch of orderJsonMatches) {
      if (ordersLimitReached) {
        console.log(`Orders limit reached for user ${userId}: ${ordersCount}/${ordersLimit}`);
      } else if (isAwaitingVerification && !isExplicitConfirmation) {
        console.log(`[PACING] Order summary review step detected for ${phoneNumber}. Waiting for customer confirmation before saving.`);
        continue;
      } else {
        try {
          let rawJson = orderJsonMatch[1].trim();
          if (rawJson.startsWith("```")) {
            rawJson = rawJson.replace(/^```(?:json)?\s*/i, "").replace(/\s*```$/, "").trim();
          }
          const orderData = JSON.parse(rawJson);
          console.log("Saving order to database:", JSON.stringify(orderData));

          const customerPhone = orderData.customer_phone || orderData.phone || orderData.customerPhone || phoneNumber;
          const cleanCustomerPhone = customerPhone ? String(customerPhone).replace(/\D/g, "") : phoneNumber;
          const rawCustomerName = orderData.customer_name || orderData.name || orderData.customerName || orderData.customer || senderName || "Customer";
          const customerName = (typeof rawCustomerName === "object" && rawCustomerName !== null)
            ? (rawCustomerName.name || rawCustomerName.customer_name || senderName || "Customer")
            : String(rawCustomerName).trim() || "Customer";
          const customerAddress = orderData.customer_address || orderData.delivery_address || orderData.shipping_address || orderData.address || null;
          const district = orderData.district || orderData.district_city || orderData.city || null;
          const rawPm = String(orderData.payment_method || "").toLowerCase().trim();
          const paymentMethod = (rawPm.includes("bank") || rawPm.includes("transfer")) ? "bank_transfer" : "cod";

          const rawItems = orderData.order_items || orderData.items || orderData.products || [];
          let orderItems = Array.isArray(rawItems) ? rawItems.map((it: any) => {
            const rawVars = (typeof it.variations === "object" && it.variations !== null)
              ? it.variations
              : ((typeof it.selected_variations === "object" && it.selected_variations !== null) ? it.selected_variations : {});
            const cleanVariations: Record<string, string> = {};
            for (const [k, v] of Object.entries(rawVars)) {
              if (v !== null && v !== undefined && String(v).trim()) {
                cleanVariations[k] = String(v).trim();
              }
            }
            if (it.size && !cleanVariations.Size && !cleanVariations.size) {
              cleanVariations.Size = String(it.size).trim();
            }
            return {
              name: it.name || it.product_name || it.title || "Product",
              price: parseFloat(it.price || it.base_price || it.unit_price || 0) || 0,
              quantity: parseInt(it.quantity || it.qty || 1) || 1,
              ...(Object.keys(cleanVariations).length > 0 ? { variations: cleanVariations } : {}),
              product_type: it.product_type || "physical",
            };
          }) : [];

          if (orderItems.length === 0 && orderData.product) {
            orderItems = [{
              name: orderData.product,
              price: parseFloat(orderData.subtotal ?? orderData.total_amount ?? orderData.total ?? 0) || 0,
              quantity: parseInt(orderData.quantity || 1) || 1,
              product_type: "physical",
            }];
          }

          // Guard against hallucinated orders: address must be present and grounded in chat history for physical products
          const hasPhysicalItems = orderItems.some((it: any) => (it.product_type || "physical") === "physical") || orderItems.length === 0;
          if (hasPhysicalItems) {
            let isAddressGrounded = false;
            if (customerAddress && typeof customerAddress === "string" && customerAddress.trim().length >= 4) {
              const normAddress = customerAddress.toLowerCase().trim();
              if (customerInboundText.includes(normAddress)) {
                isAddressGrounded = true;
              } else {
                const addressTokens = (normAddress.match(/[\p{L}\p{M}\p{N}]{3,}/gu) || [])
                  .filter((token: string) => !["road", "street", "house", "near", "post", "office", "no", "lane", "sri", "lanka"].includes(token));
                if (addressTokens.length > 0) {
                  isAddressGrounded = addressTokens.some((token: string) => customerInboundText.includes(token));
                } else {
                  const allTokens = normAddress.match(/[\p{L}\p{M}\p{N}]{3,}/gu) || [];
                  isAddressGrounded = allTokens.some((token: string) => customerInboundText.includes(token));
                }
              }
            }

            if (!isAddressGrounded) {
              console.warn(`[SECURITY] Hallucinated order detected! Address "${customerAddress}" was not provided by customer in chat.`);
              hallucinatedOrderDetected = true;
              continue;
            }
          }

          let totalAmount = parseFloat(orderData.total_amount ?? orderData.total ?? orderData.totalPrice ?? orderData.subtotal ?? 0) || 0;
          if (totalAmount === 0 && orderItems.length > 0) {
            totalAmount = orderItems.reduce((acc: number, it: any) => acc + (it.price * it.quantity), 0);
            const deliveryFee = parseFloat(orderData.delivery_fee || orderData.delivery_price || (rawItems[0]?.delivery_fee) || 0) || 0;
            totalAmount += deliveryFee;
          }
          if (totalAmount === 0) {
            const amtMatch =
              responseText.match(/(?:Total(?:\s*Amount)?|முழுத்\s*தொகை|மொத்த\s*(?:தொகை|விலை)?|மொத்தம்|එකතුව|මුළු\s*(?:ගණන|මුදල))[\s:*]+(?:LKR|Rs\.?)?[\s:*]+([0-9,]+(?:\.[0-9]{2})?)/i) ||
              responseText.match(/(?:LKR|Rs\.?)[\s:*]+([0-9,]+(?:\.[0-9]{2})?)/i);
            if (amtMatch) totalAmount = parseFloat(amtMatch[1].replace(/,/g, "")) || 0;
          }

          // Deduplication: check if a similar order was created in the last 2 minutes
          const twoMinAgo = new Date(Date.now() - 2 * 60 * 1000).toISOString();
          const { data: recentOrders } = await supabase
            .from("orders")
            .select("id")
            .eq("user_id", userId)
            .eq("customer_phone", cleanCustomerPhone)
            .gte("created_at", twoMinAgo);

          if (recentOrders && recentOrders.length > 0) {
            console.log("Duplicate order detected, skipping creation. Existing:", recentOrders[0].id);
            orderCreated = true;
          } else {
            const instructionsList: string[] = [];
            if (orderData.customer_email) {
              instructionsList.push(`Email: ${orderData.customer_email}`);
            }
            const varSummaries = orderItems
              .filter((it: any) => it.variations && Object.keys(it.variations).length > 0)
              .map((it: any) => `${it.name}: ${Object.entries(it.variations).map(([k, v]) => `${k}=${v}`).join(", ")}`);
            if (varSummaries.length > 0) {
              instructionsList.push(`Variations: ${varSummaries.join("; ")}`);
            }
            if (orderData.special_instructions && typeof orderData.special_instructions === "string") {
              const extra = orderData.special_instructions.trim();
              if (extra && !instructionsList.some((s) => s.toLowerCase().includes(extra.toLowerCase()))) {
                instructionsList.push(extra);
              }
            }
            const cleanInstructions = instructionsList.length > 0 ? instructionsList.join(" | ") : null;

            const { data: orderResult, error: orderError } = await supabase
              .from("orders")
              .insert({
                customer_name: customerName,
                customer_phone: cleanCustomerPhone,
                whatsapp_phone: phoneNumber,
                district: district,
                customer_address: customerAddress,
                order_items: orderItems,
                payment_method: paymentMethod,
                total_amount: totalAmount,
                special_instructions: cleanInstructions,
                status: "pending",
                user_id: userId,
              })
              .select()
              .single();

            if (orderError) {
              console.error("Error saving order:", orderError);
            } else {
              console.log("Order saved successfully:", orderResult.id);
              orderCreated = true;

              // Send order notification to owner
              try {
                const { data: notifSettings } = await supabase
                  .from("settings")
                  .select("value")
                  .eq("key", "order_notifications")
                  .eq("user_id", userId)
                  .single();

                let ownerPhone = notifSettings?.value?.phone ? String(notifSettings.value.phone).replace(/\D/g, "") : null;
                if (ownerPhone) {
                  if (ownerPhone.startsWith("0") && ownerPhone.length === 10) {
                    ownerPhone = "94" + ownerPhone.substring(1);
                  } else if (ownerPhone.length === 9) {
                    ownerPhone = "94" + ownerPhone;
                  }
                  const items = orderItems
                    .map((item: any) => {
                      const varInfo = item.variations && Object.keys(item.variations).length > 0
                        ? ` (${Object.entries(item.variations).map(([k, v]) => `${k}: ${v}`).join(", ")})`
                        : "";
                      return `${item.quantity}x ${item.name}${varInfo}`;
                    })
                    .join(", ");
                  const notifMessage = `📦 New Order #${orderResult.id.substring(0, 8)}\n👤 ${customerName}\n📱 ${cleanCustomerPhone}\n🛒 ${items}\n💰 Total: ${totalAmount}\n💳 ${paymentMethod === "cod" ? "Cash on Delivery" : "Bank Transfer"}${district ? `\n🏘️ District: ${district}` : ""}${customerAddress ? `\n📍 ${customerAddress}` : ""}${cleanInstructions ? `\n📝 ${cleanInstructions}` : ""}`;

                  let sendApiKey = sessionApiKey || null;
                  if (!sendApiKey) {
                    const { data: sessionData } = await supabase
                      .from("user_wsender_sessions")
                      .select("session_api_key")
                      .eq("user_id", userId)
                      .limit(1)
                      .maybeSingle();
                    sendApiKey = sessionData?.session_api_key || null;
                  }

                  const sendEndpoint = `${supabaseUrl}/functions/v1/send-whatsapp-ibbagamuwa`;
                  const sendNotif = await fetch(sendEndpoint, {
                    method: "POST",
                    headers: {
                      Authorization: `Bearer ${supabaseServiceKey}`,
                      "Content-Type": "application/json",
                    },
                    body: JSON.stringify({
                      to: ownerPhone,
                      message: notifMessage,
                      sessionApiKey: sendApiKey,
                    }),
                  });
                  if (!sendNotif.ok) {
                    console.error("Failed to send owner notification:", await sendNotif.text());
                  } else {
                    console.log("Owner notification sent to", ownerPhone);
                  }
                }
              } catch (notifError) {
                console.error("Error sending owner notification:", notifError);
              }
            }
          }
        } catch (parseError) {
          console.error("Error parsing order JSON:", parseError);
        }
      }
    }

    // Resolve FAQ attachments: only for FAQs the AI actually used, first time per conversation, max 4 attachments
    let faqMedia: string[] = [];
    if (usedFaqIds.length > 0) {
      const candidates: string[] = [];
      for (const id of usedFaqIds) {
        const faq = faqs.find((f: any) => f.id === id);
        const urls = Array.isArray(faq?.media_urls) ? faq!.media_urls : [];
        for (const u of urls) {
          if (typeof u === "string" && u.trim() && !candidates.includes(u)) candidates.push(u);
        }
      }

      if (candidates.length > 0) {
        faqMedia = candidates.filter((u) => !alreadySentFaqMedia.has(u)).slice(0, 4);
        if (faqMedia.length > 0) {
          console.log(`FAQ attachments to send (${faqMedia.length}): ${faqMedia.join(", ")}`);
        }
      }
    }

    // Check whether the model flagged an explicit customer re-request or customer explicitly asked for photos
    const explicitTagResend = /<RESEND_IMAGES>\s*true\s*<\/RESEND_IMAGES>/i.test(responseText);
    const explicitlyAskedForPhotos = /(?:photo|pic|image|photos|pics|images|පින්තූර|පින්තුර|ඡායාරූප|படம்|படங்கள்|புகைப்படம்)/i.test(trimmedMessage);
    const allowResend = explicitTagResend || explicitlyAskedForPhotos;

    // Helper: check whether a product name (or its unambiguous base name) appears in text
    const textMatchesProduct = (text: string, p: { name: string; baseName: string }) => {
      if (text.includes(p.name)) return true;
      return baseNameCounts[p.baseName] === 1 && p.baseName.length >= 4 && text.includes(p.baseName);
    };

    const strippedResponseText = responseText
      .replace(/<PRODUCT_MEDIA>[\s\S]*?<\/PRODUCT_MEDIA>/gi, "")
      .replace(/<ORDER_JSON>[\s\S]*?<\/ORDER_JSON>/g, "")
      .replace(/<IMAGE_URL>[\s\S]*?<\/IMAGE_URL>/g, "")
      .replace(/<VIDEO_URL>[\s\S]*?<\/VIDEO_URL>/g, "")
      .replace(/<USED_FAQS>[\s\S]*?<\/USED_FAQS>/g, "")
      .replace(/<RESEND_IMAGES>[\s\S]*?<\/RESEND_IMAGES>/g, "")
      .toLowerCase();
    const combinedLower = `${trimmedMessage} ${strippedResponseText}`.toLowerCase();

    // 1. Resolve <PRODUCT_MEDIA> tags (primary AI-driven media selection)
    const matchedProducts: Array<{ id: string; name: string; baseName: string; images: string[] }> = [];
    const productMediaMatches = Array.from(responseText.matchAll(/<PRODUCT_MEDIA>([\s\S]*?)<\/PRODUCT_MEDIA>/gi));
    for (const m of productMediaMatches) {
      const rawContent = m[1].trim();
      const entries = rawContent.includes(",") ? rawContent.split(",") : [rawContent];
      for (const entry of entries) {
        const cleaned = entry.trim();
        if (!cleaned) continue;
        const cleanNorm = cleaned.toLowerCase().replace(/\s+/g, " ");
        let prod = productById.get(cleaned) || productByName.get(cleaned.toLowerCase());
        if (!prod) {
          prod = products.find((p: any) => {
            const pNorm = (p.name || "").toLowerCase().replace(/\s+/g, " ");
            return pNorm === cleanNorm || pNorm.includes(cleanNorm) || cleanNorm.includes(pNorm);
          });
        }
        if (prod) {
          const mediaEntry = productsWithImages.find((p) => p.id === prod.id);
          if (mediaEntry && !matchedProducts.includes(mediaEntry)) {
            matchedProducts.push(mediaEntry);
          }
        }
      }
    }

    // Multiple products listed (e.g. 5 reels) -> send ONE primary image per product (skip already sent unless explicit resend)
    // Single product selected (e.g. customer picks 1 reel) -> send ALL remaining unsent images for that product
    // After all images of a product are sent, do not send again unless customer explicitly asks for photos
    const isMultiProductContext = matchedProducts.length > 1;
    let imageUrls: string[] = [];
    if (isMultiProductContext) {
      for (const p of matchedProducts) {
        const primary = p.images[0];
        if (primary && (allowResend || !alreadySentImages.has(primary)) && !imageUrls.includes(primary)) {
          imageUrls.push(primary);
        }
      }
    } else if (matchedProducts.length === 1) {
      const selected = matchedProducts[0];
      for (const u of selected.images) {
        if ((allowResend || !alreadySentImages.has(u)) && !imageUrls.includes(u)) {
          imageUrls.push(u);
        }
      }
    }

    const imageUrl = imageUrls.length > 0 ? imageUrls[0] : null;

    // Extract video URL if present
    const videoUrlMatch = responseText.match(/<VIDEO_URL>([\s\S]*?)<\/VIDEO_URL>/);
    const videoUrl = videoUrlMatch ? videoUrlMatch[1].trim() : null;

    // Aggressively strip any JSON or technical markup from the response
    let cleanResponse = responseText;
    cleanResponse = cleanResponse.replace(/<PRODUCT_MEDIA>[\s\S]*?<\/PRODUCT_MEDIA>/gi, "");
    cleanResponse = cleanResponse.replace(/<ORDER_JSON>[\s\S]*?<\/ORDER_JSON>/g, "");
    cleanResponse = cleanResponse.replace(/<IMAGE_URL>[\s\S]*?<\/IMAGE_URL>/g, "");
    cleanResponse = cleanResponse.replace(/<VIDEO_URL>[\s\S]*?<\/VIDEO_URL>/g, "");
    cleanResponse = cleanResponse.replace(/<USED_FAQS>[\s\S]*?<\/USED_FAQS>/g, "");
    cleanResponse = cleanResponse.replace(/<RESEND_IMAGES>[\s\S]*?<\/RESEND_IMAGES>/g, "");
    cleanResponse = cleanResponse.replace(/<PRODUCT_MEDIA>[\s\S]*/gi, "");
    cleanResponse = cleanResponse.replace(/<ORDER_JSON>[\s\S]*/g, "");
    cleanResponse = cleanResponse.replace(/<IMAGE_URL>[\s\S]*/g, "");
    cleanResponse = cleanResponse.replace(/<VIDEO_URL>[\s\S]*/g, "");
    cleanResponse = cleanResponse.replace(/<USED_FAQS>[\s\S]*/g, "");
    cleanResponse = cleanResponse.replace(/<RESEND_IMAGES>[\s\S]*/g, "");
    cleanResponse = cleanResponse.replace(/\[ID:[^\]]*\]/gi, "");
    cleanResponse = cleanResponse.replace(/<\/?[A-Z_]+>/g, "");
    cleanResponse = cleanResponse.replace(/```[\s\S]*?```/g, "");
    cleanResponse = cleanResponse.replace(/!\[.*?\]\([^\)]+\)/g, "");
    cleanResponse = cleanResponse.replace(/\[(?:View\s*)?Images?[^\]]*\]\(?[^\)]*\)?/gi, "");
    cleanResponse = cleanResponse.replace(/\{[^{}]*"customer_name"[^}]*\}/g, "");
    cleanResponse = cleanResponse.replace(/\{[^{}]*"customername"[^}]*\}/g, "");
    cleanResponse = cleanResponse.replace(/\{[^{}]*"order_items"[^}]*\}/g, "");
    cleanResponse = cleanResponse.replace(/\{[^{}]*"payment_method"[^}]*\}/g, "");
    cleanResponse = cleanResponse.replace(/\{[^{}]*"total_amount"[^}]*\}/g, "");
    cleanResponse = cleanResponse.replace(/\{\s*"[^"]+"\s*:[\s\S]*?\}/g, "");
    cleanResponse = cleanResponse.replace(/^https?:\/\/[^\s]+$/gm, "");
    cleanResponse = cleanResponse.replace(/\b[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\b/gi, "");
    cleanResponse = cleanResponse.replace(/\[FAQ_ID:[^\]]*\]/g, "");
    cleanResponse = cleanResponse.replace(/\*\*([^*\n]+)\*\*/g, "*$1*");
    cleanResponse = cleanResponse.replace(/(?:^\s*[*•-]\s*$\n?)+/gm, "");
    cleanResponse = cleanResponse.replace(/\n{3,}/g, "\n\n").trim();

    // If order details were hallucinated without customer providing address, intercept false confirmation
    if (hallucinatedOrderDetected) {
      const hasSinhala = /[\u0D80-\u0DFF]/.test(customerInboundText || trimmedMessage);
      const hasTamil = /[\u0B80-\u0BFF]/.test(customerInboundText || trimmedMessage);
      cleanResponse = hasSinhala
        ? "ඇණවුම සම්පූර්ණ කිරීම සඳහා කරුණාකර ඔබගේ නම, භාණ්ඩ ලැබිය යුතු සම්පූර්ණ ලිපිනය සහ දුරකථන අංකය අපට එවන්න. 🌸"
        : hasTamil
          ? "உங்கள் ஆர்டரை முடிக்க, தயவுசெய்து உங்கள் பெயர், டெலிவரி முகவரி மற்றும் தொலைபேசி எண்ணை அனுப்பவும். 🌸"
          : "To complete your order, please provide your name, full delivery address, and phone number.";
    }

    // Log AI usage independently of conversations
    await supabase.from("ai_usage_logs").insert({
      user_id: userId,
      phone_number: contactKey || phoneNumber,
    });

    // If an order was created, check for follow-up message
    let followupMessage: string | null = null;
    if (orderCreated) {
      try {
        const { data: followupSettings } = await supabase
          .from("settings")
          .select("value")
          .eq("key", "order_followup_message")
          .eq("user_id", userId)
          .single();

        if (followupSettings?.value?.enabled && followupSettings?.value?.text?.trim()) {
          followupMessage = followupSettings.value.text.trim();
          console.log("Order follow-up message will be sent");
        }
      } catch (e) {
        console.warn("Could not fetch order followup setting:", e);
      }
    }

    return new Response(
      JSON.stringify({ response: cleanResponse, orderCreated, imageUrl, imageUrls, videoUrl, followupMessage, faqMedia }),
      { headers: { ...corsHeaders, "Content-Type": "application/json" } }
    );
  } catch (error) {
    console.error("AI Chat error:", error);
    return new Response(
      JSON.stringify({ error: (error as Error).message }),
      { status: 500, headers: { ...corsHeaders, "Content-Type": "application/json" } }
    );
  }
});
