function bytesToBase64(bytes: Uint8Array): string {
  let binary = "";
  for (let offset = 0; offset < bytes.length; offset += 8192) {
    binary += String.fromCharCode(...bytes.subarray(offset, offset + 8192));
  }
  return btoa(binary);
}

export async function transcribeAudio(
  sessionName: string,
  wahaMessageId: string,
  mediaUrl?: string,
  mimeType?: string
): Promise<string | null> {
  const WAHA_BASE = (Deno.env.get("WAHA_BASE_URL") || "").replace(/\/+$/, "");
  const WAHA_KEY = Deno.env.get("WAHA_API_KEY") || "";
  const AI_GENERATE_URL = Deno.env.get("AI_GENERATE_URL") || "";
  const BOT_API_KEY = Deno.env.get("BOT_API_KEY") || "";
  const OPENROUTER_API_KEY = Deno.env.get("OPENROUTER_API_KEY") || "";

  // 1. Download WAHA Audio
  let audioBuffer: Uint8Array;
  try {
    const rawUrl = mediaUrl || `${WAHA_BASE}/api/${encodeURIComponent(sessionName)}/messages/${encodeURIComponent(wahaMessageId)}/download`;
    const wahaUrl = rawUrl.replace(/^https?:\/\/(?:localhost|127\.0\.0\.1):3000\b/i, WAHA_BASE || "http://waha:3000");
    console.log(`Downloading audio from: ${wahaUrl}`);
    const res = await fetch(wahaUrl, {
      headers: { "X-Api-Key": WAHA_KEY, "Accept": "*/*" },
      signal: AbortSignal.timeout(15_000)
    });

    if (!res.ok) {
      console.error(`WAHA download failed (${res.status}): ${await res.text()}`);
      return null;
    }

    audioBuffer = new Uint8Array(await res.arrayBuffer());
    console.log(`Downloaded ${audioBuffer.length} bytes of audio data`);
  } catch (err) {
    console.error("Error downloading audio from WAHA:", err);
    return null;
  }

  const cleanMime = (mimeType || "audio/ogg").split(";")[0].trim() || "audio/ogg";
  const base64Audio = bytesToBase64(audioBuffer);
  const dataUrl = `data:${cleanMime};base64,${base64Audio}`;

  // 2. Primary Provider: Direct AI Gateway (AI_GENERATE_URL) with BOT_API_KEY
  if (AI_GENERATE_URL && BOT_API_KEY) {
    try {
      console.log("Transcribing audio using primary AI Gateway (AI_GENERATE_URL)...");
      const res = await fetch(AI_GENERATE_URL, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "x-bot-key": BOT_API_KEY,
        },
        body: JSON.stringify({
          messages: [
            {
              role: "system",
              content: "You are a verbatim speech-to-text transcriber for WhatsApp voice messages in Sri Lanka. The language could be Sinhala, English, Tamil, or Singlish. Transcribe the spoken audio verbatim in its native language/script (Sinhala script for Sinhala, Tamil script for Tamil, Latin script for English/Singlish). Do NOT translate. Do NOT summarize. Do NOT add preamble, quotes, markdown formatting, or commentary. Output ONLY the exact transcribed words. If the audio has no speech or is unintelligible noise, output [UNINTELLIGIBLE]."
            },
            {
              role: "user",
              content: "Transcribe this audio verbatim:\n" + dataUrl
            }
          ],
          model: "google/gemini-2.5-flash",
          maxTokens: 500,
        }),
        signal: AbortSignal.timeout(30_000),
      });

      if (res.ok) {
        const data = await res.json();
        let text = (data?.text || "").trim();
        text = text.replace(/^["'`]+|["'`]+$/g, "").trim();
        if (text && text !== "[UNINTELLIGIBLE]") {
          console.log("Primary AI Gateway transcription successful:", text);
          return text;
        } else {
          console.warn(`Primary AI Gateway returned unintelligible: "${text}", trying OpenRouter...`);
        }
      } else {
        console.warn(`Primary AI Gateway failed (${res.status}): ${await res.text()}, trying OpenRouter...`);
      }
    } catch (err) {
      console.warn("Primary AI Gateway error:", err);
    }
  }

  // 3. Fallback Provider: OpenRouter (with dataUrl in image_url format and max_tokens constraint)
  if (OPENROUTER_API_KEY) {
    try {
      console.log("Transcribing audio using OpenRouter fallback...");
      const orRes = await fetch("https://openrouter.ai/api/v1/chat/completions", {
        method: "POST",
        headers: {
          "Authorization": `Bearer ${OPENROUTER_API_KEY}`,
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          model: "google/gemini-2.5-flash",
          max_tokens: 500,
          messages: [
            {
              role: "user",
              content: [
                {
                  type: "text",
                  text: "You are a verbatim speech-to-text transcriber for WhatsApp voice messages in Sri Lanka. Transcribe this audio verbatim in its native language/script (Sinhala, Tamil, English, or Singlish). Do NOT translate or summarize. Output ONLY the exact transcribed words. If the audio has no speech or is unintelligible noise, output [UNINTELLIGIBLE]."
                },
                {
                  type: "image_url",
                  image_url: {
                    url: dataUrl
                  }
                }
              ]
            }
          ]
        }),
        signal: AbortSignal.timeout(30_000)
      });

      if (orRes.ok) {
        const orData = await orRes.json();
        let transcription = orData?.choices?.[0]?.message?.content?.trim();
        transcription = (transcription || "").replace(/^["'`]+|["'`]+$/g, "").trim();
        if (transcription && transcription !== "[UNINTELLIGIBLE]") {
          console.log("OpenRouter transcription successful:", transcription);
          return transcription;
        }
      } else {
        console.error(`OpenRouter transcription failed (${orRes.status}): ${await orRes.text()}`);
      }
    } catch (err) {
      console.error("Error transcribing audio via OpenRouter:", err);
    }
  }

  return null;
}
