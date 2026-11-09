#!/usr/bin/env node
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

const results = [];

async function runTest(testName, fn) {
  process.stdout.write(`⏳ Running: ${testName}... `);
  const start = Date.now();
  try {
    await fn();
    const duration = ((Date.now() - start) / 1000).toFixed(1);
    console.log(`\x1b[32m✔ PASS\x1b[0m (${duration}s)`);
    results.push({ name: testName, status: "PASS", duration });
  } catch (err) {
    const duration = ((Date.now() - start) / 1000).toFixed(1);
    console.log(`\x1b[31m✖ FAIL\x1b[0m (${duration}s)`);
    console.error(`   \x1b[31mError: ${err.message}\x1b[0m`);
    results.push({ name: testName, status: "FAIL", error: err.message, duration });
  }
}

function assert(condition, message) {
  if (!condition) {
    throw new Error(message);
  }
}

async function main() {
  console.log("=================================================================");
  console.log("   AUTOMATED VERIFICATION SUITE: AI CHAT CATALOG REASONING");
  console.log("=================================================================\n");

  // TEST 1: General Category Query
  await runTest("Test 1: Category Query ('What lures do you have?')", async () => {
    const res = await callAiChat("What lures do you have?");
    const reply = res.response || "";

    assert(
      !reply.toLowerCase().includes("only in combo") && !reply.toLowerCase().includes("only in our combo"),
      "Must NOT claim lures are only available in combos"
    );

    const matchesLures = [
      /frog/i.test(reply),
      /popper/i.test(reply),
      /radium|glow/i.test(reply),
      /soft bite/i.test(reply),
      /noby/i.test(reply)
    ].filter(Boolean).length;

    assert(matchesLures >= 3, `Must identify multiple distinct lure types (found ${matchesLures}/5)`);
    assert(/LKR|Rs/i.test(reply), "Must include pricing info (LKR or Rs)");
  });

  // TEST 2: Specific Product Identification
  await runTest("Test 2: Specific Identification ('You have popper frog lure')", async () => {
    const res = await callAiChat("You have popper frog lure");
    const reply = res.response || "";

    assert(/yes|have|available/i.test(reply), "Must confirm product availability");
    assert(/750/.test(reply), "Must accurately identify Popper Frog price of LKR 750");
    assert(!/not listed separately|only in kit/i.test(reply), "Must NOT claim it is unlisted or kit-only");
  });

  // TEST 3: Typo & Phonetic Tolerance
  await runTest("Test 3: Typo Matching ('Soft bite lire')", async () => {
    const res = await callAiChat("Soft bite lire");
    const reply = res.response || "";

    assert(/soft bite/i.test(reply), "Must identify Soft Bite Lure despite the 'lire' typo");
    assert(/1,?900/.test(reply), "Must cite the correct price of LKR 1900");
    assert(!/only in combo|spin master only/i.test(reply), "Must NOT claim it is only in combo kit");
  });

  // TEST 4: Multilingual Translation (Tamil)
  await runTest("Test 4: Multilingual Resolution ('ரேடியம் lure' in Tamil)", async () => {
    const res = await callAiChat("ரேடியம் lure");
    const reply = res.response || "";

    assert(/1,?200/.test(reply), "Must recognize Radium Lure and cite LKR 1200");
    assert(/[\u0B80-\u0BFF]/.test(reply), "Must respond in Tamil script to a Tamil customer query");
    assert(!/இல்லை|not available/i.test(reply), "Must NOT claim radium lures are unavailable");
  });

  // TEST 5: Standalone vs Bundled Disambiguation
  await runTest("Test 5: Standalone vs Combo Disambiguation ('Can I buy AC 7000 reel alone?')", async () => {
    const res = await callAiChat("Can I buy the AC 7000 reel alone?");
    const reply = res.response || "";

    assert(/yes|available|can buy|purchase/i.test(reply), "Must confirm reel can be purchased standalone");
    assert(/3,?900/.test(reply), "Must cite standalone reel price of LKR 3900");
    assert(!/only available in|must buy set/i.test(reply), "Must NOT claim reel is only in a combo package");
  });

  // TEST 6: Multi-Turn Context Continuity
  await runTest("Test 6: Multi-Turn Context Continuity (Rod selection then lure addition)", async () => {
    const history = [
      { direction: "inbound", message: "Hi, I am interested in the Galaxy Diamond rod", created_at: new Date(Date.now() - 30000).toISOString() },
      { direction: "outbound", message: "Great choice! The Galaxy Diamond rod is LKR 4,500. It is a 2-piece carbon rod for large fish. Would you like to add any reels or lures?", created_at: new Date(Date.now() - 20000).toISOString() }
    ];

    const res = await callAiChat("Can I add 2 popper frog lures to this order?", history);
    const reply = res.response || "";

    assert(/popper frog/i.test(reply), "Must reference Popper Frog Lure in context");
    assert(/750|1,?500/.test(reply), "Must calculate or reference Popper Frog pricing (750 each or 1500 for two)");
    assert(!/only in combo/i.test(reply), "Must not hallucinate combo-only restrictions in multi-turn conversation");
  });

  // TEST 7: Dynamic Vendor Product Addition (Zero Code Changes Required)
  const tempProductId = "99999999-9999-9999-9999-999999999999";
  try {
    // 1. Vendor adds a new product to the database
    executeSql(`
      INSERT INTO ibbagamuwa_customization.products (
        id, user_id, name, price, product_type, delivery_price, description, is_active
      ) VALUES (
        '${tempProductId}',
        '${USER_ID}',
        'Squid Jig Glow Lure (දැල්ලන් Lure)',
        850.00,
        'physical',
        250.00,
        'Specialized glow squid jig lure for night saltwater cuttlefish and squid fishing. Sharp double umbrella hooks.',
        true
      );
    `);

    await runTest("Test 7A: Dynamic Product Detection ('Do you have squid jig lures?')", async () => {
      const res = await callAiChat("Do you have squid jig lures?");
      const reply = res.response || "";

      assert(/squid jig|850/i.test(reply), "Must dynamically detect the newly added product without code change");
      assert(/850/.test(reply), "Must cite the new product's price (LKR 850)");
    });

    await runTest("Test 7B: Dynamic Product Typo/Sinhala Query ('dallan jig thiyenawada')", async () => {
      const res = await callAiChat("dallan jig thiyenawada");
      const reply = res.response || "";

      assert(/squid|දැල්ලන්|850/i.test(reply), "Must semantically match Singlish 'dallan' to the newly added product");
      assert(/850/.test(reply), "Must cite the correct price LKR 850");
    });

  } finally {
    // 2. Clean up test product
    executeSql(`DELETE FROM ibbagamuwa_customization.products WHERE id = '${tempProductId}';`);
  }

  // Print Summary
  console.log("\n=================================================================");
  console.log("                     TEST EXECUTION SUMMARY");
  console.log("=================================================================");
  const passed = results.filter(r => r.status === "PASS").length;
  const failed = results.filter(r => r.status === "FAIL").length;
  console.log(`Total Tests: ${results.length} | Passed: \x1b[32m${passed}\x1b[0m | Failed: ${failed > 0 ? `\x1b[31m${failed}\x1b[0m` : "0"}`);
  console.log("=================================================================\n");

  if (failed > 0) {
    process.exit(1);
  }
}

main().catch(err => {
  console.error("Test runner crashed:", err);
  process.exit(1);
});

