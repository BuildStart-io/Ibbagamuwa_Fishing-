#!/usr/bin/env node
/**
 * Automated Verification Suite: Image Correctness & Lure Type Verification
 * Tests the AI chat engine for:
 * 1. Accuracy of all lure types and pricing.
 * 2. Accuracy and association of returned product images against DB ground truth.
 * 3. Prevention of cross-product image leakage.
 * 4. Multilingual image querying (English, Sinhala, Tamil).
 * 5. Negative prompt handling (no hallucinated images for unstocked items).
 * 6. Live HTTP accessibility (200 OK) of all image assets.
 */

const { execSync } = require("child_process");

const EDGE_FUNCTION_URL = "http://localhost:8000/functions/v1/ai-chat-ibbagamuwa";
const SERVICE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoic2VydmljZV9yb2xlIiwiaXNzIjoic3VwYWJhc2UiLCJpYXQiOjE3OTM2MjQ0NTAsImV4cCI6MjEwODk4NDQ1MH0.3NSKKo_lwbQZHiQEfmH_WIzO-acB0Y0hEQErOB9yDWs";
const USER_ID = "8ec761ff-b716-411b-85d2-1b56980d1e8a";
const PHONE_NUMBER = "94706996683";

function executeSql(sql) {
  const escaped = sql.replace(/'/g, "'\\''");
  return execSync(`docker exec -i supabase-db psql -U postgres -d postgres -t -A -c '${escaped}'`, {
    encoding: "utf8"
  }).trim();
}

// Fetch ground-truth products from PostgreSQL
function getDbProducts() {
  const raw = executeSql(`
    SELECT json_agg(t) FROM (
      SELECT id, name, price, images, is_active 
      FROM ibbagamuwa_customization.products 
      WHERE user_id = '${USER_ID}' AND is_active = true
      ORDER BY price ASC
    ) t;
  `);
  return JSON.parse(raw);
}

async function callAiChat(message, conversationHistory = []) {
  const res = await fetch(EDGE_FUNCTION_URL, {
    method: "POST",
    headers: {
      "Authorization": `Bearer ${SERVICE_KEY}`,
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
      message,
      phoneNumber: PHONE_NUMBER,
      conversationHistory,
      userId: USER_ID
    })
  });

  if (!res.ok) {
    const errorText = await res.text();
    throw new Error(`Edge function returned status ${res.status}: ${errorText}`);
  }

  return await res.json();
}

async function checkUrlAccessible(url) {
  try {
    const res = await fetch(url, { method: "HEAD" });
    return res.status === 200;
  } catch (e) {
    return false;
  }
}

const testResults = [];

async function runTest(testName, fn) {
  process.stdout.write(`⏳ Running: ${testName}... `);
  const start = Date.now();
  try {
    await fn();
    const duration = ((Date.now() - start) / 1000).toFixed(1);
    console.log(`\x1b[32m✔ PASS\x1b[0m (${duration}s)`);
    testResults.push({ name: testName, status: "PASS", duration });
  } catch (err) {
    const duration = ((Date.now() - start) / 1000).toFixed(1);
    console.log(`\x1b[31m✖ FAIL\x1b[0m (${duration}s)`);
    console.error(`   \x1b[31mError: ${err.message}\x1b[0m`);
    testResults.push({ name: testName, status: "FAIL", error: err.message, duration });
  }
}

function assert(condition, message) {
  if (!condition) {
    throw new Error(message);
  }
}

async function main() {
  console.log("=================================================================");
  console.log("   AUTOMATED VERIFICATION SUITE: LURE TYPES & IMAGE ACCURACY");
  console.log("=================================================================\n");

  const allDbProducts = getDbProducts();
  const dbLures = allDbProducts.filter(p => 
    p.name.toLowerCase().includes("lure") || 
    p.name.toLowerCase().includes("frog") || 
    p.name.toLowerCase().includes("bite")
  );

  console.log(`Found ${dbLures.length} active lure products in PostgreSQL catalog:\n`);
  for (const lure of dbLures) {
    console.log(`  - [${lure.id.substring(0, 8)}] ${lure.name} (LKR ${lure.price}) -> ${lure.images?.length || 0} images`);
  }
  console.log("\n-----------------------------------------------------------------\n");

  // TEST 1: Full Lure Type Catalog Identification
  await runTest("Test 1: Full Lure Catalog ('What lures do you have?')", async () => {
    const res = await callAiChat("What lures do you have?");
    const reply = res.response || "";

    assert(!/only in combo|only available in full kit/i.test(reply), "Must not claim lures are combo-only");
    
    // Check identification of key lure types
    assert(/frog/i.test(reply), "Must identify Frog Lures");
    assert(/popper/i.test(reply), "Must identify Popper Lures");
    assert(/radium|glow/i.test(reply), "Must identify Radium / Glow Lures");
    assert(/noby|metal/i.test(reply), "Must identify Metal / Noby Lures");
    assert(/soft bite/i.test(reply), "Must identify Soft Bite Lures");
    assert(/tackle box|lure set/i.test(reply), "Must identify Lure Set with Tackle Box");

    // Check pricing presence
    assert(/650/.test(reply), "Must cite 650 for Frog Lure");
    assert(/750/.test(reply), "Must cite 750 for Popper Frog Lure");
    assert(/1,?200/.test(reply), "Must cite 1200 for Radium Lure");
  });

  // Helper for testing specific product images
  async function testProductImageAssociation(testName, query, targetProductId, expectedPrice) {
    await runTest(testName, async () => {
      const targetProduct = dbLures.find(p => p.id === targetProductId);
      assert(targetProduct, `Target product ${targetProductId} must exist in DB`);

      const res = await callAiChat(query);
      const reply = res.response || "";
      const returnedUrls = res.imageUrls || (res.imageUrl ? [res.imageUrl] : []);

      assert(returnedUrls.length > 0, `Must return at least 1 image URL for ${targetProduct.name}`);

      // Verify that every returned URL belongs strictly to the target product in DB
      const dbImageSet = new Set(targetProduct.images || []);
      for (const url of returnedUrls) {
        assert(
          dbImageSet.has(url),
          `Image URL leaked or hallucinated! Returned '${url}', which is NOT in DB for '${targetProduct.name}'`
        );
      }

      // Verify no images from other products were returned
      const otherProductImages = new Set();
      for (const other of allDbProducts) {
        if (other.id !== targetProductId && Array.isArray(other.images)) {
          for (const img of other.images) otherProductImages.add(img);
        }
      }
      for (const url of returnedUrls) {
        assert(
          !otherProductImages.has(url),
          `Cross-product contamination! Returned image belongs to another product: ${url}`
        );
      }

      // Verify pricing
      if (expectedPrice) {
        const priceRegex = new RegExp(expectedPrice.replace(",", ",?"));
        assert(priceRegex.test(reply), `Must cite correct price of LKR ${expectedPrice}`);
      }

      // Verify live HTTP status of first returned image
      const isLive = await checkUrlAccessible(returnedUrls[0]);
      assert(isLive, `Returned image URL is not accessible over HTTP: ${returnedUrls[0]}`);
    });
  }

  // TEST 2: Popper Frog Lure Image Accuracy
  await testProductImageAssociation(
    "Test 2: Popper Frog Lure Images ('Can I see photos of Popper Frog lure?')",
    "Can I see photos of Popper Frog lure?",
    "1fb4de3b-fc72-40c6-ac80-7952da30a1ba",
    "750"
  );

  // TEST 3: Yellow Snakehead Frog Lure Image Accuracy
  await testProductImageAssociation(
    "Test 3: Yellow Frog Lure Images ('Send photos of the yellow frog lure')",
    "Send photos of the yellow frog lure",
    "a4abd913-cb0b-4176-a938-6c72e6a89935",
    "650"
  );

  // TEST 4: Radium Glow Lure Image Accuracy
  await testProductImageAssociation(
    "Test 4: Radium Glow Lure Images ('Photos of radium glow lure please')",
    "Photos of radium glow lure please",
    "93e87c9c-deba-4d9f-8605-642957957822",
    "1,200"
  );

  // TEST 5: Soft Bite Lure Image Accuracy
  await testProductImageAssociation(
    "Test 5: Soft Bite Lure Images ('Show me pictures of soft bite lure')",
    "Show me pictures of soft bite lure",
    "8e0938f1-8079-4ed8-a65c-586997547d5a",
    "1,900"
  );

  // TEST 6: Noby Brand Metal Lure Image Accuracy
  await testProductImageAssociation(
    "Test 6: Noby Metal Lure Images ('Can I see images of Noby metal lure?')",
    "Can I see images of Noby metal lure?",
    "9805c714-adab-4328-91d3-c61427d4ffb8",
    "1,500"
  );

  // TEST 7: Surface Popper Lure Image Accuracy
  await testProductImageAssociation(
    "Test 7: Surface Popper Lure Images ('Send photos of surface popper lure')",
    "Send photos of surface popper lure",
    "cfc40b98-a51e-4e4f-9cc5-363bd360e381",
    "1,500"
  );

  // TEST 8: Multilingual Image Query - Sinhala
  await runTest("Test 8: Sinhala Image Request ('පොපර් ගෙම්බා photos එවන්න')", async () => {
    const targetProduct = dbLures.find(p => p.id === "1fb4de3b-fc72-40c6-ac80-7952da30a1ba");
    const res = await callAiChat("පොපර් ගෙම්බා photos එවන්න");
    const reply = res.response || "";
    const returnedUrls = res.imageUrls || (res.imageUrl ? [res.imageUrl] : []);

    assert(returnedUrls.length > 0, "Must return image URLs for Sinhala photo request");
    assert(targetProduct.images.includes(returnedUrls[0]), "Must return correct Popper Frog image for Sinhala query");
    assert(/750/.test(reply), "Must state price LKR 750");
  });

  // TEST 9: Multilingual Image Query - Tamil
  await runTest("Test 9: Tamil Image Request ('ரேடியம் லූර් படங்கள் பார்க்க முடியுமா?')", async () => {
    const targetProduct = dbLures.find(p => p.id === "93e87c9c-deba-4d9f-8605-642957957822");
    const res = await callAiChat("ரேடியம் லූර් படங்கள் பார்க்க முடியுமா?");
    const reply = res.response || "";
    const returnedUrls = res.imageUrls || (res.imageUrl ? [res.imageUrl] : []);

    assert(returnedUrls.length > 0, "Must return image URLs for Tamil photo request");
    assert(targetProduct.images.includes(returnedUrls[0]), "Must return correct Radium Lure image for Tamil query");
    assert(/1,?200/.test(reply), "Must state price LKR 1200");
  });

  // TEST 10: Negative Image Test (Non-Stocked Item)
  await runTest("Test 10: Negative Image Test - Unstocked Item ('Show photos of fly fishing nymphs')", async () => {
    const res = await callAiChat("Show photos of fly fishing nymphs");
    const reply = res.response || "";
    const returnedUrls = res.imageUrls || (res.imageUrl ? [res.imageUrl] : []);

    assert(returnedUrls.length === 0, "Must NOT hallucinate or attach images for items not in stock");
    assert(/don't have|not available|do not carry|sorry/i.test(reply), "Must state that item is not available");
  });

  // TEST 11: Non-Lure Category Isolation (Reel Image Check)
  await runTest("Test 11: Cross-Category Image Isolation ('Photos of AC7000 reel')", async () => {
    const ac7000 = allDbProducts.find(p => p.id === "52710284-2d95-430a-8ec4-a98aff2eddb6");
    assert(ac7000, "AC7000 reel must exist in DB");

    const res = await callAiChat("Can you send photos of the AC7000 reel?");
    const reply = res.response || "";
    const returnedUrls = res.imageUrls || (res.imageUrl ? [res.imageUrl] : []);

    assert(returnedUrls.length > 0, "Must return image URLs for AC7000 reel");
    assert(ac7000.images.includes(returnedUrls[0]), "Must return AC7000 reel images");

    // Ensure none of the returned URLs are lures
    for (const lure of dbLures) {
      for (const lureImg of (lure.images || [])) {
        assert(!returnedUrls.includes(lureImg), `Lure image leaked into reel query: ${lureImg}`);
      }
    }
  });

  console.log("\n=================================================================");
  console.log("                     TEST EXECUTION SUMMARY");
  console.log("=================================================================");
  const passed = testResults.filter(r => r.status === "PASS").length;
  const failed = testResults.filter(r => r.status === "FAIL").length;
  console.log(`Total Tests: ${testResults.length} | Passed: ${passed} | Failed: ${failed}`);
  console.log("=================================================================\n");

  if (failed > 0) {
    process.exit(1);
  }
}

main().catch(err => {
  console.error("Fatal error running test suite:", err);
  process.exit(1);
});

