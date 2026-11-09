-- Migration: Reorganize products database to prevent AI hallucinations and misidentifications
-- Schema: ibbagamuwa_customization

BEGIN;

-- 1. LURES (STANDALONE - SOLD INDIVIDUALLY)
UPDATE ibbagamuwa_customization.products 
SET name = 'Frog Lure (Yellow Snakehead Frog / ගෙම්බා Lure)',
    price = 650.00,
    description = 'High quality yellow hollow-body frog lure with sharp double hooks. Ideal for Snakehead (Lulla / ලූලා) topwater fishing in tanks and lakes. Available individually.'
WHERE id = 'a4abd913-cb0b-4176-a938-6c72e6a89935';

UPDATE ibbagamuwa_customization.products 
SET name = 'Popper Frog Lure (Topwater Frog / පොපර් ගෙම්බා)',
    price = 750.00,
    description = 'Topwater popping frog lure with sharp hooks and splash action to provoke aggressive predator strikes. Available individually.'
WHERE id = '1fb4de3b-fc72-40c6-ac80-7952da30a1ba';

UPDATE ibbagamuwa_customization.products 
SET name = 'Radium Lure (Glow in Dark / Rediam Lure / රේඩියම් ලූර්)',
    price = 1200.00,
    description = 'Glow in dark / radium finish lure (40g, 50g), colors: White, Red & Silver. Ideal for night and deep/murky water fishing. Available individually.'
WHERE id = '93e87c9c-deba-4d9f-8605-642957957822';

UPDATE ibbagamuwa_customization.products 
SET name = 'Popper Lure (Surface Popper 40g / 60g)',
    price = 1500.00,
    description = 'Surface popper lure (40g, 60g). Colors: Red & Silver, Green & Black, Rose & Red. Excellent surface disturbance for predatory fish. Available individually.'
WHERE id = 'cfc40b98-a51e-4e4f-9cc5-363bd360e381';

UPDATE ibbagamuwa_customization.products 
SET name = 'Noby Brand Metal Lure (40g / 60g)',
    price = 1500.00,
    description = 'High quality Noby brand metal casting lure available in 40g and 60g weights for long-distance casting. Available individually.'
WHERE id = '9805c714-adab-4328-91d3-c61427d4ffb8';

UPDATE ibbagamuwa_customization.products 
SET name = 'Generic Brand Casting Lures',
    price = 1500.00,
    description = 'Versatile casting lures for freshwater and saltwater predatory fish. Available individually.'
WHERE id = '142bb4be-489f-4864-aad6-5b9e586f8a0e';

UPDATE ibbagamuwa_customization.products 
SET name = 'Soft Bite Lure (Packet of 4 pcs / සොෆ්ට් බයිට්)',
    price = 1900.00,
    description = 'Soft silicone fish bite lures (Packet of 4 pcs). Lifelike tail swimming action for predator fish. Available individually.'
WHERE id = '8e0938f1-8079-4ed8-a65c-586997547d5a';

UPDATE ibbagamuwa_customization.products 
SET name = 'Lure Set with Tackle Box (5 pcs + Box)',
    price = 1900.00,
    description = 'Complete set of 5 pieces 14g lures packaged neatly with a clear multi-compartment tackle box. Available individually.'
WHERE id = 'b5075f6f-3e47-4ce2-a7ba-0fcf0ff29ab1';

-- 2. STANDALONE FISHING RODS
UPDATE ibbagamuwa_customization.products 
SET name = 'Normal Quality Telescopic Rod',
    description = 'Compact telescopic fishing rod (6ft - 14ft), 2-5kg drag. Lightweight and convenient to carry.'
WHERE id = 'e2773a81-9f4d-45b1-8e81-c811dcf0a6bb';

UPDATE ibbagamuwa_customization.products 
SET name = 'Premium Black Telescopic Rod (Astika)',
    description = 'High quality black Astika telescopic rod, 5-8kg drag capacity. Available in 6-8ft, 9-12ft, and 12-15ft.'
WHERE id = 'ae07755e-4b3b-49a2-9d81-5f766df2ea2f';

UPDATE ibbagamuwa_customization.products 
SET name = 'Astika Green Fiber Rod (Treat)',
    description = 'Durable green fiber rod from Astika brand. Available in 6-7ft, 8ft, and 10ft.'
WHERE id = '4c68fe16-89f0-4584-9b7b-ee0a954a39d5';

UPDATE ibbagamuwa_customization.products 
SET name = 'Spin Master Carbon Fiber Two-Piece Rod',
    description = 'High performance 2-piece carbon fiber rod (6ft - 10ft), 8-12kg drag. Made in Thailand.'
WHERE id = '8a544493-25da-47dc-8eb5-9c99343ec861';

UPDATE ibbagamuwa_customization.products 
SET name = 'Galaxy Diamond Carbon Two-Piece Rod',
    description = 'Heavy-duty 2-piece carbon fiber rod (6ft - 10ft), 15-20kg drag capacity for large predatory fish.'
WHERE id = '70e52f6e-e4da-4e71-bb4b-d0d7b1e3e0a2';

-- 3. STANDALONE REELS
UPDATE ibbagamuwa_customization.products 
SET name = 'AC7000 Fishing Reel (Metal Spool)',
    description = 'Metal spinning reel, available in AC4000, AC5000, and AC7000 sizes. 5-8kg drag.'
WHERE id = '52710284-2d95-430a-8ec4-a98aff2eddb6';

UPDATE ibbagamuwa_customization.products 
SET name = 'HT7000 Heavy Duty Fishing Reel',
    description = 'Heavy duty spinning reel for deep water and big fish.'
WHERE id = '3d2454eb-9e4b-443e-b5f5-0bc001c4062c';

-- 4. STANDALONE ACCESSORIES & FLOATS
UPDATE ibbagamuwa_customization.products 
SET name = 'Fishing Float (ඉපියා / Bobber)',
    description = 'Standard high-visibility 10g fishing float / bobber (ඉපියා).'
WHERE id = '68720b46-4cb3-4f3a-82d1-6afc59e391f2';

-- Deactivate duplicate float
UPDATE ibbagamuwa_customization.products 
SET is_active = false
WHERE id = '49c75128-3d2b-4486-b1ec-4fc3483b0e60';

UPDATE ibbagamuwa_customization.products 
SET name = 'Long Fishing Float (දිගු ඉපියා)',
    description = 'High visibility long-stem float (LKR 200) for deep water or current fishing.'
WHERE id = 'bda767de-323a-4853-a15c-bd8d27217f17';

UPDATE ibbagamuwa_customization.products 
SET name = 'Fishing Wire Cable Trace (ශක්තිමත් කේබල්)',
    description = 'Heavy-duty steel wire cable trace with swivel and snap to prevent toothy fish bite-offs.'
WHERE id = '7918bb35-3a31-49ba-9b2f-81cbe10a4047';

-- 5. COMBO KITS (COMPLETE FULL SETS)
UPDATE ibbagamuwa_customization.products 
SET name = 'Kitul Stick Fishing Setup (කිතුල් පිත්ත Setup)',
    description = 'Traditional complete Kitul stick setup with rod, line, hook and float.'
WHERE id = '8a264c7f-5bbd-4af4-a424-e7cd379c0a4b';

UPDATE ibbagamuwa_customization.products 
SET name = 'Astika Telescopic Full Set 6500',
    description = 'Complete starter combo with Astika telescopic rod (6ft-10ft), FF500 reel, 100m line, hook box, and float.'
WHERE id = '0415624b-f860-43ea-97f3-eed7b4251179';

-- Deactivate duplicate astika 6500 with typo
UPDATE ibbagamuwa_customization.products 
SET is_active = false
WHERE id = '542a5b4a-cf4a-42d6-b22b-0fdd12bcffa5';

UPDATE ibbagamuwa_customization.products 
SET name = 'Astika Premium Telescopic Full Set 7500',
    description = 'Astika premium telescopic rod set with AC 5000 reel, line, hooks and float.'
WHERE id = '699f5e78-09ad-4bac-96ba-ce179a02f158';

UPDATE ibbagamuwa_customization.products 
SET name = 'Astika Two-Piece Full Set 8500',
    description = 'Astika two-piece rod setup with reel, line, hooks and float.'
WHERE id = '3d1424d8-630b-4aac-adfc-a9e1f30f57ec';

UPDATE ibbagamuwa_customization.products 
SET name = 'Carbon Fiber Combo Set 8900 (8 Feet)',
    description = '8ft carbon fiber combo with AC 7000 reel for up to 15kg fish. Includes line, hooks, and accessories.'
WHERE id = 'e0f2c372-92d5-4770-bd4f-8faa7acd5d4f';

UPDATE ibbagamuwa_customization.products 
SET name = 'Spin Master Carbon Full Kit 10500',
    description = 'Complete combo kit made in Thailand: 2-piece carbon rod with AC 7000 reel, 100m line, hook box, soft lure, frog lure, cable and float. Drag 15-18kg.'
WHERE id = 'c8804335-0617-41f0-be4a-3767ecf07b8a';

UPDATE ibbagamuwa_customization.products 
SET name = 'Galaxy Diamond Full Set 12500',
    description = 'Heavy duty Galaxy Diamond combo with MQ reel, line, hooks and full accessories for 15-20kg fish.'
WHERE id = 'c483d000-1292-409d-b09e-0f38c0d44b91';

UPDATE ibbagamuwa_customization.products 
SET name = 'Double Astika Set + Free Rod (15,000 Pkg)',
    description = '2 complete Astika rod sets + 1 free telescopic rod included.'
WHERE id = '9616d08e-0c0f-400a-a267-60bec5e9b196';

COMMIT;
