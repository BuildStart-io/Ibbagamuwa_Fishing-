-- ============================================================================
-- Seed 23 Fishing Products for Ibbagamuwa Fishing Centre
-- Combos/Full Sets, Lures, Wire Cables/Lines, Floats, and Tackle Accessories
-- ============================================================================

INSERT INTO ibbagamuwa_customization.products (
  user_id,
  name,
  description,
  price,
  delivery_price,
  product_type,
  variations,
  images,
  is_active
) VALUES
-- 1. Full Sets / Combo Kits
(
  'b099b43a-06da-43d5-893e-afa4a3764015',
  'Starter Fishing Combo Kit (FH-01)',
  'Complete beginner combo kit: Telescopic carbon fiber rod, 2000 series spinning reel, 100m monofilament line, tackle box with hooks, sinkers & floats. Extended Length: 6ft / 7ft (Closed Length: 40cm). Includes lightweight travel carry bag. Perfect for river and reservoir angling.',
  6500.00,
  450.00,
  'physical',
  '[
    {
      "name": "Rod Length & Reel",
      "options": [
        {"label": "6ft Extended (Closed: 40cm) with 2000 Reel", "price": 6500},
        {"label": "7ft Extended (Closed: 45cm) with 3000 Reel", "price": 7500}
      ]
    }
  ]'::jsonb,
  ARRAY[
    'https://images.unsplash.com/photo-1544943910-4c1dc44aab44?w=800&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1516962215378-7fa2e137ae93?w=800&auto=format&fit=crop'
  ],
  true
),
(
  'b099b43a-06da-43d5-893e-afa4a3764015',
  'Intermediate Angler Rod & Reel Combo (FH-02)',
  'High-performance carbon medium-heavy rod with smooth 3000/4000 series 8+1 BB spinning reel. Includes 150m 4X braided PE line, 3 weedless frog lures, 2 minnow lures, and tackle box. Foldable handle with EVA ergonomic grip. Closed Length: 45cm.',
  11500.00,
  450.00,
  'physical',
  '[
    {
      "name": "Combo Configuration",
      "options": [
        {"label": "7ft Medium Action (Closed: 45cm) + 3000 Reel", "price": 11500},
        {"label": "8ft Heavy Action (Closed: 50cm) + 4000 Reel", "price": 12800}
      ]
    }
  ]'::jsonb,
  ARRAY[
    'https://images.unsplash.com/photo-1516962215378-7fa2e137ae93?w=800&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1529230117010-b6c436154f25?w=800&auto=format&fit=crop'
  ],
  true
),
(
  'b099b43a-06da-43d5-893e-afa4a3764015',
  'Pro Full Tackle & Rod Package (FH-03)',
  'Full pro angler setup: 9ft/10ft High-Modulus Carbon Rod, 5000/6000 all-metal spool reel with 15kg max drag, 300m 8X braided PE line, full lure box (poppers, crankbaits, weedless frogs, spoons), heavy-duty pliers, fish lip gripper, and water-resistant padded travel rod case.',
  18500.00,
  500.00,
  'physical',
  '[
    {
      "name": "Rod & Reel Tier",
      "options": [
        {"label": "9ft Pro Heavy Action (Closed: 55cm) + 5000 Reel", "price": 18500},
        {"label": "10ft Pro Extra Heavy (Closed: 60cm) + 6000 Reel", "price": 21000}
      ]
    }
  ]'::jsonb,
  ARRAY[
    'https://images.unsplash.com/photo-1529230117010-b6c436154f25?w=800&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1544943910-4c1dc44aab44?w=800&auto=format&fit=crop'
  ],
  true
),
(
  'b099b43a-06da-43d5-893e-afa4a3764015',
  'Ultralight Micro-Fishing Combo (FH-04)',
  '5.5ft 2-piece ultra-sensitive carbon rod paired with a 1000 series shallow-spool spinning reel. Includes 100m 4lb fluorocarbon line, 10 micro spoons and jig heads. Excellent for freshwater streams, canals, and small tilapia angling. Closed Length: 88cm (2-piece).',
  8900.00,
  450.00,
  'physical',
  '[
    {
      "name": "Color Finish",
      "options": [
        {"label": "Stealth Matte Black", "price": 8900},
        {"label": "Metallic Royal Blue", "price": 8900}
      ]
    }
  ]'::jsonb,
  ARRAY[
    'https://images.unsplash.com/photo-1544943910-4c1dc44aab44?w=800&auto=format&fit=crop'
  ],
  true
),
(
  'b099b43a-06da-43d5-893e-afa4a3764015',
  'Telescopic Pocket Travel Rod & Reel Set (FH-05)',
  'Ultra-compact telescopic pocket rod that collapses down to just 32cm, extending to 5ft. Mini metal spinning reel with pre-spooled line and pocket tackle box. Maximum mobility for motorcycle, bicycle, or backpack travel across fishing spots.',
  4800.00,
  350.00,
  'physical',
  '[
    {
      "name": "Extended Length",
      "options": [
        {"label": "5ft Extended (Closed: 32cm)", "price": 4800},
        {"label": "6ft Extended (Closed: 38cm)", "price": 5400}
      ]
    }
  ]'::jsonb,
  ARRAY[
    'https://images.unsplash.com/photo-1516962215378-7fa2e137ae93?w=800&auto=format&fit=crop'
  ],
  true
),
(
  'b099b43a-06da-43d5-893e-afa4a3764015',
  'Heavy Reservoir Trolling & Boat Kit (FH-06)',
  '6.6ft 2-piece heavy boat rod, high-capacity baitcasting/multiplier reel, 300m 50lb braided line, deep diver lures, and stainless steel wire leaders. Built for large reservoir predators and deep water boat fishing.',
  16500.00,
  500.00,
  'physical',
  '[
    {
      "name": "Reel Handle Orientation",
      "options": [
        {"label": "Right Hand Retrieve", "price": 16500},
        {"label": "Left Hand Retrieve", "price": 16500}
      ]
    }
  ]'::jsonb,
  ARRAY[
    'https://images.unsplash.com/photo-1529230117010-b6c436154f25?w=800&auto=format&fit=crop'
  ],
  true
),

-- 2. Lures
(
  'b099b43a-06da-43d5-893e-afa4a3764015',
  'Thunder Frog Weedless Topwater Lure (Set of 3)',
  'Realistic silicone frog bodies with concealed double high-carbon steel hooks and silicone skirts. Weedless design glides over lotus leaves and weeds without snagging. Specifically weighted for snakehead (Lula) and barramundi (Modha). Weight: 13g each.',
  1850.00,
  350.00,
  'physical',
  '[
    {
      "name": "Color Pack",
      "options": [
        {"label": "Jungle Green & Yellow Frog (Set of 3)", "price": 1850},
        {"label": "Dark Bullfrog & Red Belly (Set of 3)", "price": 1850},
        {"label": "Luminous Glow Night Frogs (Set of 3)", "price": 2100}
      ]
    }
  ]'::jsonb,
  ARRAY[
    'https://images.unsplash.com/photo-1583212292454-1fe6229603b7?w=800&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1548199973-03cce0bbc87b?w=800&auto=format&fit=crop'
  ],
  true
),
(
  'b099b43a-06da-43d5-893e-afa4a3764015',
  'Deep Diving Holographic Crankbait (FH-L02)',
  '14g floating diving crankbait with steel ball sound rattle. Dives 2.5m - 4.5m on retrieve. Realistic 3D eyes and laser reflection finish with dual anti-rust treble hooks.',
  950.00,
  350.00,
  'physical',
  '[
    {
      "name": "Color Pattern",
      "options": [
        {"label": "Firetiger (Orange/Green Stripe)", "price": 950},
        {"label": "Silver Flash Minnow", "price": 950},
        {"label": "Golden Shiner", "price": 950}
      ]
    }
  ]'::jsonb,
  ARRAY[
    'https://images.unsplash.com/photo-1583212292454-1fe6229603b7?w=800&auto=format&fit=crop'
  ],
  true
),
(
  'b099b43a-06da-43d5-893e-afa4a3764015',
  'Laser Minnow Jerkbait Lures (5-Pack Set)',
  '11cm / 13g suspending minnow jerkbaits with razor-sharp treble hooks. Life-like darting action mimicking wounded baitfish. Great for freshwater reservoir predators.',
  2600.00,
  350.00,
  'physical',
  '[
    {
      "name": "Set Style",
      "options": [
        {"label": "Standard Natural Baitfish 5-Pack", "price": 2600},
        {"label": "UV Reactive Bright Colors 5-Pack", "price": 2800}
      ]
    }
  ]'::jsonb,
  ARRAY[
    'https://images.unsplash.com/photo-1583212292454-1fe6229603b7?w=800&auto=format&fit=crop'
  ],
  true
),
(
  'b099b43a-06da-43d5-893e-afa4a3764015',
  'Topwater Surface Popper Lure (FH-L04)',
  'Cupped mouth face creates loud popping sounds and surface water splashing that trigger explosive topwater strikes. Equipped with rear feathered treble hook.',
  850.00,
  350.00,
  'physical',
  '[
    {
      "name": "Lure Size & Weight",
      "options": [
        {"label": "8cm (12g)", "price": 850},
        {"label": "10cm (18g)", "price": 1050}
      ]
    }
  ]'::jsonb,
  ARRAY[
    'https://images.unsplash.com/photo-1583212292454-1fe6229603b7?w=800&auto=format&fit=crop'
  ],
  true
),
(
  'b099b43a-06da-43d5-893e-afa4a3764015',
  'Reflective Metal Jigging Spoon Set (Pack of 4)',
  'Aerodynamic heavy casting spoons with high-reflectivity chrome finish, laser scale patterns, and feathered treble hooks. Excellent casting distance against wind.',
  1600.00,
  350.00,
  'physical',
  '[
    {
      "name": "Weight Combination",
      "options": [
        {"label": "20g Spoons (Pack of 4)", "price": 1600},
        {"label": "30g Spoons (Pack of 4)", "price": 1850}
      ]
    }
  ]'::jsonb,
  ARRAY[
    'https://images.unsplash.com/photo-1621609764095-b32bbe35cf3a?w=800&auto=format&fit=crop'
  ],
  true
),
(
  'b099b43a-06da-43d5-893e-afa4a3764015',
  'Soft Plastic Grub & Worm Kit with 5 Jig Heads (35 Pcs)',
  'Assorted soft silicone curly tail grubs and ribbed paddle-tail worms infused with fish attractant scent. Includes 5 barbed lead jig heads (3.5g, 5g, 7g) in a transparent tackle organizer.',
  1950.00,
  350.00,
  'physical',
  '[
    {
      "name": "Color Assortment",
      "options": [
        {"label": "Bright Neon & Glow Mix (35 pcs)", "price": 1950},
        {"label": "Natural Earth & Olive Mix (35 pcs)", "price": 1950}
      ]
    }
  ]'::jsonb,
  ARRAY[
    'https://images.unsplash.com/photo-1583212292454-1fe6229603b7?w=800&auto=format&fit=crop'
  ],
  true
),
(
  'b099b43a-06da-43d5-893e-afa4a3764015',
  'Vibration VIB Blade Metal Lure (FH-L07)',
  '15g zinc alloy sinking vibration lure with multiple tow points to change vibrating frequency. Emits strong vibration pulses on fast retrieve.',
  750.00,
  350.00,
  'physical',
  '[
    {
      "name": "Color Finish",
      "options": [
        {"label": "Silver Hologram", "price": 750},
        {"label": "Gold Red-Head", "price": 750}
      ]
    }
  ]'::jsonb,
  ARRAY[
    'https://images.unsplash.com/photo-1621609764095-b32bbe35cf3a?w=800&auto=format&fit=crop'
  ],
  true
),

-- 3. Cables / Lines / Leaders
(
  'b099b43a-06da-43d5-893e-afa4a3764015',
  'Stainless Steel Anti-Bite Wire Leader Cables (10-Pack)',
  '7-strand nylon-coated stainless steel wire leader cables with heavy-duty barrel swivels and quick duo-lock snaps. Prevents bite-offs from sharp-toothed fish like snakehead and barramundi.',
  650.00,
  300.00,
  'physical',
  '[
    {
      "name": "Cable Length",
      "options": [
        {"label": "15cm Wire Leader (10 Pcs)", "price": 650},
        {"label": "20cm Wire Leader (10 Pcs)", "price": 750},
        {"label": "30cm Wire Leader (10 Pcs)", "price": 850}
      ]
    }
  ]'::jsonb,
  ARRAY[
    'https://images.unsplash.com/photo-1606768666853-403c90a981ad?w=800&auto=format&fit=crop'
  ],
  true
),
(
  'b099b43a-06da-43d5-893e-afa4a3764015',
  '4-Strand Braided PE Fishing Line (300m Spool)',
  'Zero stretch, high knot strength, abrasion-resistant 4X polyethylene superline for effortless long-distance casting and high sensitivity to bites.',
  2200.00,
  350.00,
  'physical',
  '[
    {
      "name": "Test Strength (Line Rating)",
      "options": [
        {"label": "15 lb (0.14mm - 300m) Moss Green", "price": 2200},
        {"label": "20 lb (0.18mm - 300m) Moss Green", "price": 2200},
        {"label": "30 lb (0.23mm - 300m) Moss Green", "price": 2400},
        {"label": "40 lb (0.28mm - 300m) High-Vis Yellow", "price": 2400}
      ]
    }
  ]'::jsonb,
  ARRAY[
    'https://images.unsplash.com/photo-1606768666853-403c90a981ad?w=800&auto=format&fit=crop'
  ],
  true
),
(
  'b099b43a-06da-43d5-893e-afa4a3764015',
  '8-Strand Extreme Braid PE Line (500m Spool)',
  'Ultra-smooth 8-carrier woven braid line. Perfectly round profile reduces friction through rod guides for whisper-quiet and maximum casting distance.',
  4500.00,
  350.00,
  'physical',
  '[
    {
      "name": "Line Rating",
      "options": [
        {"label": "20 lb (Multicolor 10m Metered - 500m)", "price": 4500},
        {"label": "30 lb (Moss Green - 500m)", "price": 4500},
        {"label": "50 lb (High-Vis Yellow - 500m)", "price": 4800}
      ]
    }
  ]'::jsonb,
  ARRAY[
    'https://images.unsplash.com/photo-1606768666853-403c90a981ad?w=800&auto=format&fit=crop'
  ],
  true
),
(
  'b099b43a-06da-43d5-893e-afa4a3764015',
  '100% Fluorocarbon Shock Leader Cable (50m Spool)',
  'High-density fluorocarbon shock leader. Near-zero visibility underwater with extreme abrasion resistance against rocks, submerged trees, and snags.',
  1750.00,
  300.00,
  'physical',
  '[
    {
      "name": "Leader Diameter",
      "options": [
        {"label": "20 lb (0.37mm - 50m)", "price": 1750},
        {"label": "30 lb (0.45mm - 50m)", "price": 1950},
        {"label": "40 lb (0.52mm - 50m)", "price": 2200}
      ]
    }
  ]'::jsonb,
  ARRAY[
    'https://images.unsplash.com/photo-1606768666853-403c90a981ad?w=800&auto=format&fit=crop'
  ],
  true
),
(
  'b099b43a-06da-43d5-893e-afa4a3764015',
  'Extra Strong Monofilament Nylon Line (500m)',
  'Durable smooth casting monofilament with controlled stretch and superior knot strength. Crystal clear underwater visibility.',
  1100.00,
  300.00,
  'physical',
  '[
    {
      "name": "Line Thickness",
      "options": [
        {"label": "0.28mm (14 lb - 500m)", "price": 1100},
        {"label": "0.35mm (20 lb - 500m)", "price": 1250},
        {"label": "0.40mm (26 lb - 500m)", "price": 1400}
      ]
    }
  ]'::jsonb,
  ARRAY[
    'https://images.unsplash.com/photo-1606768666853-403c90a981ad?w=800&auto=format&fit=crop'
  ],
  true
),

-- 4. Floats / Bobbers
(
  'b099b43a-06da-43d5-893e-afa4a3764015',
  'Luminous LED Night Fishing EVA Floats (Set of 3)',
  'High-density waterproof EVA foam floats with internal LED battery chamber. Highly visible light stick glowing up to 100 meters at night. Includes 3 replaceable lithium pin batteries.',
  1450.00,
  350.00,
  'physical',
  '[
    {
      "name": "Buoyancy Rating",
      "options": [
        {"label": "20g Buoyancy (Set of 3)", "price": 1450},
        {"label": "30g Buoyancy (Set of 3)", "price": 1650},
        {"label": "50g Heavy Buoyancy (Set of 3)", "price": 1850}
      ]
    }
  ]'::jsonb,
  ARRAY[
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&auto=format&fit=crop'
  ],
  true
),
(
  'b099b43a-06da-43d5-893e-afa4a3764015',
  'Precision Balsa Wood Slip Floats (Pack of 5)',
  'Ultra-sensitive natural balsa wood slip bobbers with high-visibility fluorescent tops. Detects even the lightest nibbles from tilapia, carp, and gourami.',
  1200.00,
  300.00,
  'physical',
  '[
    {
      "name": "Float Size",
      "options": [
        {"label": "Medium 15cm (Pack of 5)", "price": 1200},
        {"label": "Long Stem 20cm (Pack of 5)", "price": 1400}
      ]
    }
  ]'::jsonb,
  ARRAY[
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&auto=format&fit=crop'
  ],
  true
),
(
  'b099b43a-06da-43d5-893e-afa4a3764015',
  'Oval Snap-On Hard Foam Strike Indicator Floats (10-Pack)',
  'Classic spring push-button snap-on bobbers in bright fluorescent red/white and yellow/white. Keeps your bait securely held at the chosen water depth.',
  800.00,
  300.00,
  'physical',
  '[
    {
      "name": "Bobber Diameter",
      "options": [
        {"label": "1.0 Inch (10 Pcs)", "price": 800},
        {"label": "1.5 Inch (10 Pcs)", "price": 950},
        {"label": "2.0 Inch (10 Pcs)", "price": 1100}
      ]
    }
  ]'::jsonb,
  ARRAY[
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&auto=format&fit=crop'
  ],
  true
),
(
  'b099b43a-06da-43d5-893e-afa4a3764015',
  'Smart Gravity Sensor LED Night Float',
  'High-tech electronic night float equipped with a smart gravity sensor chip. Glows steady soft green while floating naturally on water ripples, and instantly flashes rapid bright red when a fish bites and pulls down.',
  1350.00,
  350.00,
  'physical',
  '[
    {
      "name": "Float Body Length",
      "options": [
        {"label": "Standard 35cm (Single Unit + Battery)", "price": 1350},
        {"label": "Deep Reservoir 42cm (Single Unit + Battery)", "price": 1550}
      ]
    }
  ]'::jsonb,
  ARRAY[
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&auto=format&fit=crop'
  ],
  true
),

-- 5. Tackle Accessories
(
  'b099b43a-06da-43d5-893e-afa4a3764015',
  'Heavy Duty Aluminum Fishing Pliers & Lip Gripper Combo',
  'Aviation-grade corrosion-resistant aluminum alloy pliers with tungsten carbide line cutters, split-ring tooth, and crimper. Paired with a heavy stainless steel fish lip gripper with safety coiled lanyard and sheath.',
  3200.00,
  350.00,
  'physical',
  '[
    {
      "name": "Anodized Color",
      "options": [
        {"label": "Titanium Grey & Blue", "price": 3200},
        {"label": "Crimson Red & Black", "price": 3200}
      ]
    }
  ]'::jsonb,
  ARRAY[
    'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=800&auto=format&fit=crop'
  ],
  true
),
(
  'b099b43a-06da-43d5-893e-afa4a3764015',
  'Waterproof Double-Sided Tackle Box Organizer',
  'High-impact ABS construction with waterproof silicone sealing ring and stainless steel hinge pins. Double-sided storage with customizable divider compartments for lures, swivels, hooks, and weights.',
  1800.00,
  350.00,
  'physical',
  '[
    {
      "name": "Box Size",
      "options": [
        {"label": "Medium (20cm x 15cm x 5cm)", "price": 1800},
        {"label": "Large (27cm x 18cm x 5cm)", "price": 2400}
      ]
    }
  ]'::jsonb,
  ARRAY[
    'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=800&auto=format&fit=crop'
  ],
  true
);

