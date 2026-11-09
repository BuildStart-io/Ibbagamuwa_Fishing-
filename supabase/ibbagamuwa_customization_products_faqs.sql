-- =============================================================================
-- Schema: ibbagamuwa_customization
-- Products & FAQs Seed / Backup Script
-- Total Products: 33 | Total FAQs: 5
-- =============================================================================

-- 1. Insert Products
INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    'b2493b13-3c32-4845-95e5-5525028c0511', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'diamond rod+ Ac 7000', 'diamond+rod
100m line
hook box+lure
cable+float
rod cover', 10500.0, 0, 'physical', '[]'::jsonb, '{}'::text[], NULL, false, '2026-11-05T06:44:54.054176+00:00', '2026-11-09T04:40:05.825938+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    '50370560-0c89-4a85-bb02-71426f842cf1', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'Spin Master Rod full set', 'Spin Master Rod
ac 6000 reel
100m line
hook box mix
soft lure
frog
cable
float', 10500.0, 0, 'physical', '[]'::jsonb, '{}'::text[], NULL, false, '2026-11-05T06:46:18.46408+00:00', '2026-11-09T04:40:05.825938+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    '888c77c9-23d1-4055-ad4d-b68e86f1d266', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'astaka full set', 'spinning reel
fishing line
float
lure
fishing box
hooks
', 8500.0, 0, 'physical', '[]'::jsonb, '{}'::text[], NULL, false, '2026-11-05T06:47:41.007568+00:00', '2026-11-09T04:40:05.825938+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    '175e31de-98b0-419d-811a-32650a049adf', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'Full fising set', 'ac 7000 reel
line
lure
float
hooks
calculator
markerpen', 11999.0, 0, 'physical', '[]'::jsonb, '{}'::text[], NULL, false, '2026-11-05T06:49:06.051432+00:00', '2026-11-09T04:40:05.825938+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    '8a264c7f-5bbd-4af4-a424-e7cd379c0a4b', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', '🎣 කිතුල් පිත්තෙන් මාළු අල්ලන අයට සුපිරි Fishing Setup එකක්! 😍🔥', '🎣 කිතුල් පිත්තෙන් මාළු අල්ලන අයට සුපිරි Fishing Setup එකක්! 😍🔥

kg 4-6 yk drag 
reccomend  kg 2-3 
💰 සම්පූර්ණ Setup එකම රු. 2,900/-යි!
✅ කිතුල් Stik
✅ තැගුස් නූල්
✅ ඉපියෝ
✅ කටු Box
✅ Lures

🐟 මාළු අල්ලන්න කැමති අයට හොඳම තේරීම! 👌
📦 දිවයින පුරා Delivery පහසුකම් ඇත.

🔥 රු. 2,900/- පමණයි!', 2900.0, 0, 'physical', '[{"name": "hight", "options": [{"label": "6-9 feet ", "price": 2900}, {"label": "9-15feet", "price": 3499.98}]}]'::jsonb, ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/82459ce2-5791-458c-b6d3-b6995c1db761.png', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/0395ad11-3e8f-4e34-a62b-a32c8bffb4ab.png']::text[], NULL, true, '2026-11-05T06:49:43.339034+00:00', '2026-11-05T16:13:58.733205+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    '542a5b4a-cf4a-42d6-b22b-0fdd12bcffa5', '5543a79b-21f1-4091-905b-025d39acd0c8', 'Astika fishing ull set 6500', '🎣🔥 FISHING CENTER – SPECIAL PRICE DROP! 🔥🎣

🐟 ගඟේ, වැවේ මාළු අල්ලන ඔයාලට සුපිරි Fishing Setup එකක්! 💯😍

💥 Rs. 6,800/- වෙනුවට දැන් Rs. 6500/- පමණයි! 🔥

🎣 ASITIKA Telescopic Rod Set එකේ විශේෂත්වයන් 👇

✅ උස 6ft සිට 10ft දක්වා සකස් කරගත හැකියි 📏
✅ FF500 Thousand Reel එකක් 🎣
✅ 100m Fishing Line එකක් 🧵
✅ Hook Box එකක් 🪝
✅ ඉපියෝ (Float) එකක් 🔴⚪

🔥 අඩු මිලට සුපිරි Fishing Setup එකක් ගන්න දැන්ම අපිට කතා කරන්න!

📞 Call / WhatsApp: 0720209902', 6500.0, 550, 'physical', '[]'::jsonb, ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-5543a79b-21f1-4091-905b-025d39acd0c8/products/34b8180b-94dd-4143-b95f-787f25b9cc93.jpg']::text[], NULL, true, '2026-11-05T09:13:56.479896+00:00', '2026-11-05T09:13:56.479896+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    'e2773a81-9f4d-45b1-8e81-c811dcf0a6bb', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'Normal quality telescope rod ', 'Delevery charge eka 450 or 550
2-5 kg darg
🎣 අඩු මිලට සුපිරි Fishing Rod එකක් හොයන අයට මෙන්න අනගි අවස්ථාවක්! 🔥
💥 TYP Telescope Rod
✅ Lightweight & Easy to Carry
✅ Strong & Durable
✅ Freshwater & Saltwater Fishing සඳහා සුදුසුයි
💰 මිල රු. 2,000 සිට පමණයි! ❤️
🚚 දිවයින පුරා Delivery පහසුකම්
💵 Cash on Delivery (COD) පහසුකමත් ඇත.
📲 අදම Order කරන්න! ', 2000.0, 0, 'physical', '[{"name": "Height ", "options": [{"label": "6feet", "price": 2000, "subVariants": [{"name": "", "options": [{"label": "", "price": 0}], "required": false}]}, {"label": "7feet ", "price": 2200}, {"label": "8feet ", "price": 2500}, {"label": "9feet", "price": 2900}, {"label": "10feet", "price": 3200}, {"label": "12-14feet", "price": 3500}]}]'::jsonb, ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/8b17a3b8-fbe4-458f-99e6-42a74174bad7.png', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/c8c1ba23-5add-4811-b015-48157aa12419.png', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/d648e669-5fb0-41e4-a7aa-3ec5e6a3138f.png']::text[], NULL, true, '2026-11-05T20:28:40.086696+00:00', '2026-11-06T13:14:36.225974+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    'ae07755e-4b3b-49a2-9d81-5f766df2ea2f', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'Premiam Quality telescope Rod blackcolor', 'brand aasttika 
nrmal fiber
5-8 kg drag
reccomend 5kg
🎣 අඩුම මිලට සුපිරි Telescopic Fishing Rod එකක්! ❤️🔥

✅ පහසුවෙන් රැගෙන යා හැකියි
✅ ශක්තිමත් සහ උසස් තත්ත්වයේ
✅ ආරක්ෂිත Carry Bag එකත් සමඟ

💰 මිල රු. 3,000 සිට පමණයි!

📦 අදම ඔබේ Order එක වෙන්කරවා ගන්න!

🐟 මසුන් ඇල්ලීමට කැමති ඔබටමයි මේ සුපිරි අවස්ථාව! ❤️

', 3000.0, 550, 'physical', '[{"name": "highit", "options": [{"label": "6-8 feet ", "price": 3000}, {"label": "9-12 feet", "price": 3500}, {"label": "12-15 feet ", "price": 4100}]}]'::jsonb, ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/30f68c7f-004a-4089-b026-442bba78c579.png', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/ba71bcbc-3118-4e1e-a793-cc30e0b38c2a.png', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/4b26a913-7e1a-4132-a627-6ab3a2517817.png']::text[], NULL, true, '2026-11-06T13:13:33.738055+00:00', '2026-11-06T13:45:49.681821+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    '4c68fe16-89f0-4584-9b7b-ee0a954a39d5', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'Fiber rod treat green color astika brand', '🎣 ASTIKA Brand Fishing Rod එකක් දැන් රු. 3,500 සිට! 🔥❤️
💪 7–10KG දක්වා බරක් දරාගත හැකි ශක්තිමත් Fishing Rod එකක්.
🐟 මසුන් අල්ලන්න කැමති ඔබට සුපිරිම තේරීමක්!
✅ ASTIKA Brand
✅ ශක්තිමත් නිමාව
✅ වර්ණ කිහිපයකින් ලබාගත හැකියි
📦 දිවයින පුරා Delivery පහසුකම්!
📲 අදම Order කරන්න!
📍 IBBAGAMUWA FISHING CENTER', 3500.0, 550, 'physical', '[{"name": "Highit", "options": [{"label": "6-7feet", "price": 2900, "subVariants": [{"name": "", "options": [{"label": "", "price": 0}], "required": false}]}, {"label": "8feet", "price": 3500}, {"label": "10feet", "price": 4100}]}]'::jsonb, ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/5a77edbb-2f42-42ab-804d-ea7126b3a1fa.png', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/a452f63b-0cbf-4980-a0f6-1f3d489a05de.png', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/799499e5-9798-4081-abab-41e17ca1ae13.png']::text[], NULL, true, '2026-11-06T14:29:44.170614+00:00', '2026-11-06T14:29:44.170614+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    '8a544493-25da-47dc-8eb5-9c99343ec861', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'Spin master carbon fibor two piece rod', 'Drag kg 8-12 
Carbon fiber 
Two piec 
Made in thailand🎣🔥 Spin Master Fishing Rod දැන් ඔබට IBBAGAMUWA FISHING CENTER වෙතින්!
💪 ශක්තිමත් නිමාවක් • සැහැල්ලු බරක් • සුපිරි ක්‍රියාකාරීත්වයක්!
💰 මිල ගණන් 👇
🔹 අඩි 6 – රු. 3,900/-
🔹 අඩි 7/8 – රු. 4,500/-
🔹 අඩි 9 – රු. 5,500/-
🔹 අඩි 10 – රු. 6,500/-
🚚 දිවයින පුරා Delivery පහසුකම්!
💵 Cash on Delivery පහසුකමත් ඇත.
🐟 අදම ඔබේ Fishing Rod එක Order කරන්න!
📍 IBBAGAMUWA FISHING CENTER', 3900.0, 550, 'physical', '[{"name": "Hight ", "options": [{"label": "6feet", "price": 3900}, {"label": "7-8feet", "price": 4500}, {"label": "9feet", "price": 5500}, {"label": "10feet", "price": 6500}]}]'::jsonb, ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/629e0e46-a352-4b08-80a3-9fe30a89bbb0.png', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/bc0164f5-bf5e-4dc6-b71c-91f8b4e31184.png']::text[], NULL, true, '2026-11-06T14:45:41.369591+00:00', '2026-11-06T14:45:41.369591+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    '70e52f6e-e4da-4e71-bb4b-d0d7b1e3e0a2', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'Glaxy Diamond Rod ', '🎣🔥 මහදියට සුපිරිම Fishing Rod එකක්! 🔥🎣

Carbon fiber 
Two piece 
💪 KG 15–20 අතර බරක් දරාගත හැකි ශක්තිමත් Rod එකක්!
📏 අඩි 6 සිට 12 දක්වා Sizes රැසක් उपलब्धයි.

💰 මිල රු. 4,500 සිට පමණයි! ❤️

🐟 ලොකු මාළු අල්ලන්න කැමති ඔබට සුපිරිම තේරීමක්!

📲 අදම ORDER කරන්න!
', 4500.0, 550, 'physical', '[{"name": "Highit", "options": [{"label": "6feet", "price": 3900}, {"label": "7feet", "price": 4500}, {"label": "8feet", "price": 5500}, {"label": "9feet", "price": 6500}, {"label": "10feer", "price": 7500}]}]'::jsonb, ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/2108b7ed-5cab-4b5c-a1cf-68bcacad7646.png', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/2c8ee06c-aea5-4ea3-aaca-0a911a926d0b.png', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/15c69d59-966f-4a6d-9c9b-b2e7a2c157d7.png']::text[], NULL, true, '2026-11-06T15:06:10.915154+00:00', '2026-11-06T15:06:10.915154+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    '0415624b-f860-43ea-97f3-eed7b4251179', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'AASTIKA TELESCOPE 6500 SET ', ' drag kg 2-5
NORMAL FIBER
BRAND ASTIKA 
made in chaina 
FISHING CENTER – SPECIAL PRICE DROP! 🔥🎣

🐟 ගඟේ, වැවේ මාළු අල්ලන ඔයාලට සුපිරි Fishing Setup එකක්! 💯😍

💥 Rs. 6,800/- වෙනුවට දැන් Rs. 6500/- පමණයි! 🔥

🎣 ASITIKA Telescopic Rod Set එකේ විශේෂත්වයන් 👇

✅ උස 6ft සිට 10ft දක්වා සකස් කරගත හැකියි 📏
✅ FF500 Thousand Reel එකක් 🎣
✅ 100m Fishing Line එකක් 🧵
✅ Hook Box එකක් 🪝
✅ ඉපියෝ (Float) එකක් 🔴⚪

🔥 අඩු මිලට සුපිරි Fishing Setup එකක් ගන්න දැන්ම අපිට කතා කරන්න!

📞 Call / WhatsApp: 072 9724365', 6500.0, 550, 'physical', '[]'::jsonb, ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/03b04118-c401-40b5-aafc-06882affbd31.png', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/d05a96ac-b91d-4408-acab-6726d7a5c919.png']::text[], NULL, true, '2026-11-07T08:25:58.03611+00:00', '2026-11-07T08:25:58.03611+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    '699f5e78-09ad-4bac-96ba-ce179a02f158', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'astika premiam telescope rod full set 7500', '
🎣🔥 Astika Premium Telescope Rod – Full Set එකම රු. 7,500යි! ❤️

drag kg 5-8
bran pro version astika telscope 
yes fiber rod 
9-15 feet price 7900
ඔබේ මසුන් ඇල්ලීමේ අත්දැකීම තවත් සුපිරි කරගන්න! 🐟

✅ 6 – 8 Feet Telescope Rod
✅ AC 5000 Spinning Reel
✅ 100m Fishing Line
✅ Hooks Box
✅ Float
✅ Lure

💥 සියල්ලම එකම පැකේජයකින් රු. 7,500/- පමණයි!

📍 Ibbagamuwa Fishing Center
🎣 අදම ඇණවුම් කරන්න!', 7500.0, 550, 'physical', '[]'::jsonb, ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/096cebc1-12e3-4a67-aa12-261e807f2c84.png', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/0a483cdf-cf9c-45c4-a290-5d97a370309e.png']::text[], NULL, true, '2026-11-07T08:46:00.460432+00:00', '2026-11-07T08:46:00.460432+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    '3d1424d8-630b-4aac-adfc-a9e1f30f57ec', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'Astika Two piecs full set 8500', '
🎣🔥 සුපිරි Fishing Full Set එකක් දැන් රු. 8,500/- පමණයි!
drag kg 10-12
brand astika ,crocodile 
china 
මසුන් ඇල්ලීම ආරම්භ කරන්න අවශ්‍ය සියලුම උපකරණ එකම පැකේජයකින්! ❤️

✅ Astika Brand Fishing Rod
✅ Spinning Reel
✅ Fishing Line
✅ Floats
✅ Lures
✅ Hooks & Accessories
✅ Fishing Bag

💥 සම්පූර්ණ SET එකම රු. 8,500/-

🚚 Cash on Delivery පහසුකමත් ඇත!

📍 Ibbagamuwa Fishing Center
Dambulla Road, Thorayaya, Kurunegala.

📞 072 972 4365 / 078 932 6637

🐟 අදම Order කරන්න!', 8500.0, 550, 'physical', '[]'::jsonb, ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/8f8fcfe2-0e2e-40d3-881f-b513be2e2844.png', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/6c1e7b38-b01d-4eaa-b540-7faa9c5b6d89.jpg']::text[], NULL, true, '2026-11-07T08:52:41.343555+00:00', '2026-11-07T08:52:41.343555+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    'e0f2c372-92d5-4770-bd4f-8faa7acd5d4f', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'carbon fiber full set 89', '🎣🔥 CARBON FIBER FISHING COMBO SET 🔥🐟

💪 කිලෝ 15ක් දක්වා මාළු අල්ලන්න පුළුවන් සුපිරි Setup එකක්! 😍🎣

✅ Carbon Fiber 8 Feet Rod
✅ AC 7000 Reel
✅ Line Pack
✅ Hooks Box 🪝
✅ Lure 🎯
✅ Cable
✅ Float
✅ Rod Cover 🎒

🐟 Beginner කෙනෙක්ටත් සුපිරි Fishing Combo එකක්! 🔥

📦 Islandwide Delivery Available 🚚
📲 Order කරන්න දැන්ම WhatsApp Message එකක් දාන්න!

🎣 IBBAGAMUWA FISHING CENTER ❤️‍🔥', 8900.0, 650, 'physical', '[]'::jsonb, ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/5dd896d2-9bba-4539-9826-7f9c53e9b5ed.png', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/9fcfd6c4-070c-4267-885c-677a7fbcfba8.png', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/36eee69f-6e9e-4ff1-9584-5d22b51ed645.png']::text[], NULL, true, '2026-11-07T09:05:19.49362+00:00', '2026-11-07T09:05:19.49362+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    'c8804335-0617-41f0-be4a-3767ecf07b8a', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'spin master full kit 10500', 'made in thailand 
carbon fiber rod 
two piece 
kg drag 15-18

💥 FULL FISHING SET එකම රු. 10500/- පමණයි! 💥

🐟 මාළු අල්ලන්න ආස ඔයාලට සුපිරි අවස්ථාවක්! 😍

✅ Spin Master Rod 🎣
✅ AC 7000 Reel ⚙️
✅ 100M Fishing Line 🧵
✅ Hook Box Mix 🪝
✅ Soft Lure 🐠
✅ Frog Lure 🐸
✅ Cable & Float 🎯

⏳ මෙම විශේෂ මිල මාසයක් පමණයි! 🔥

💯 සියලුම අවශ්‍ය දේවල් එකම SET එකකින්!

🚚 දිවයින පුරා Delivery පහසුකම ඇත.
💵 Cash on Delivery පහසුකමත් ඇත!

📍 IBBAGAMUWA FISHING CENTER
📌 Dambulla Road, Thorayaya, Kurunegala

📞 072 972 4365 / 078 932 6637

📲 අදම WhatsApp හරහා හෝ Inbox එකට Message කරලා ORDER කරන්න! 🎣🐟

🔥 ඔබේ ඊළඟ මසුන් ඇල්ලීමේ අත්දැකීම අදම ආරම්භ කරන්න! 🔥
ඔයා බලලා oder එක දාන්න ❤️', 10500.0, 650, 'physical', '[{"name": "highit ", "options": [{"label": "8feet", "price": 10500}, {"label": "9feet", "price": 11500}, {"label": "10feet", "price": 12500}]}]'::jsonb, ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/4a3f033d-9848-4a34-8df8-27873b05b563.jpg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/9daab756-b3e1-43ae-b76a-dac67bda4623.png', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/221addec-1484-4e33-9efb-0cf89d7f54eb.png']::text[], NULL, true, '2026-11-07T09:37:24.527098+00:00', '2026-11-07T09:37:24.527098+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    'c483d000-1292-409d-b09e-0f38c0d44b91', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'Glaxy Diamond Full Set ', 'glaxy diamon rod 
brand dimod 8 feet 12500
9feet 13500
10feet 14500
🎣🔥 DIAMOND ROD SET – සුපිරි Fishing Package එකක්! 🔥

මසුන් ඇල්ලීමට අවශ්‍ය සියලුම උපකරණ එකම පැකේජයකින් දැන් ඔබට ලබාගන්න පුළුවන්! ❤️

💥 විශේෂ මිල රු. 13,500/- පමණයි!

📦 පැකේජයට ඇතුළත් දේවල්:
✅ Diamond Fishing Rod
✅ MQ Reel
✅ 100m Fishing Line
✅ Hooks Box
✅ Lure
✅ Cable
✅ Floats
✅ Rod Cover

🎯 ආධුනික සහ පළපුරුදු ධීවරයන්ටත් සුදුසුයි!

📍 IBBAGAMUWA FISHING CENTER

📩 අදම අපට Inbox කරන්න. ඔබේ Fishing Setup එක අදම සූදානම් කරගන්න! 🎣❤️', 12500.0, 650, 'physical', '[]'::jsonb, ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/769c042e-d140-4197-8604-2eea767249b5.png']::text[], NULL, true, '2026-11-07T09:47:38.020305+00:00', '2026-11-07T09:47:38.020305+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    '9616d08e-0c0f-400a-a267-60bec5e9b196', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', '15000pkg astika rod free tlescope rod ', '🎣🔥 SET 2 – COMPLETE FISHING ROD SETUP! 🔥🎣

💥 Special Price: Rs. 15,000/- ONLY! 💥

🎁 FREE BONUS – Telescope Rod 1ක්!

✅ Astika Brand 8 Feet Rod × 2
✅ AC 7000 Reel × 2
✅ Bread Line × 2
✅ Hook Box × 2
✅ Float × 2
✅ Rod Bag × 2
🎁 FREE Telescope Rod 1ක්!

🐟 මාළු අල්ලන්න ආස ඔයාලට සුපිරිම අවස්ථාවක්! 😍🔥

📍 IBBAGAMUWA FISHING CENTER
📌 Dambulla Road, Thorayaya

📞 072 972 4365 | 078 932 6637

🚚 Cash on Delivery Available!
⚡ මේ වගේ Complete Setup එකක් මේ මිලට ගන්න දැන්ම අපිට කතා කරන්න!', 15000.0, 850, 'physical', '[]'::jsonb, ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/b642a7d3-30b2-4979-836a-9198787ec1ac.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/125b7a14-1893-48bd-8448-266dee952d74.png', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/0e003c0d-0f32-4752-ba8b-8c031fdfe4e0.png', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/b690e3e4-d7ef-47de-ae43-196941b19f54.png']::text[], NULL, true, '2026-11-07T10:08:59.180212+00:00', '2026-11-07T10:27:42.838632+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    'cfc40b98-a51e-4e4f-9cc5-363bd360e381', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'Poppor lure', 'poppor lure 
🎣🔥 මාළු අල්ලන්න කැමති අයට සුපිරි POPPER LURE එකක්! 🔥
availble coler 
red and silver
green and black 
rose and red 
🐟 40g සහ 60g බරින් ලබාගත හැකියි.
💥 ආකර්ෂණීය නිමාව
🎯 මසුන් ආකර්ෂණය කරගැනීමට කදිමයි!

💰 **මිල රු. 1,500/- පමණයි!**

📍 Ibbagamuwa Fishing Center
🛒 අදම ඇණවුම් කරන්න!', 1500.0, 250, 'physical', '[]'::jsonb, ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/a4493c98-d715-4add-a40f-c4f4a8a209e2.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/80b8a736-6a6a-4b1a-bcd8-7582b79c4b0d.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/2e75c77c-bda4-426f-9bd1-3c9ecbf2d85f.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/27e6a18d-9f10-4015-ba64-266ec7dcc1ba.jpeg']::text[], NULL, true, '2026-11-07T10:46:26.281317+00:00', '2026-11-08T04:11:44.947984+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    '9805c714-adab-4328-91d3-c61427d4ffb8', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'noby brand lure', 'noby brand lure
 40grm
60grm', 1500.0, 250, 'physical', '[]'::jsonb, ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/f4e3b4ba-cfa3-4b2b-8184-e473338452a0.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/2af8872f-dfb7-471f-8210-945a44b1b67b.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/d17d5b51-55a1-4ffe-b969-94d1f0386417.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/b440ba9a-3506-4839-9650-1c6fc0313cdf.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/5a5928b9-32e4-464e-b205-eac507e1f99a.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/1f28bd4c-2efa-4cc6-8764-fc5264de7c32.jpeg']::text[], NULL, true, '2026-11-07T11:58:08.06889+00:00', '2026-11-08T04:11:49.939897+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    '142bb4be-489f-4864-aad6-5b9e586f8a0e', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'generic brand lures', 'generic brand lures', 1500.0, 0, 'physical', '[]'::jsonb, ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/e029c487-9a24-4c45-89e0-70e9a03e7df8.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/b9e8c41b-0aa5-4162-8fa3-34d4e53c46fa.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/79aaa489-b6aa-44ee-8a6f-b2b84c404a9e.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/0dcb3498-5c9c-48c7-83a3-f1f8fe1bd491.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/b8ea7f71-fb2e-4194-ba47-40363042382e.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/7786bc75-4db6-457f-acde-1c77b47b80f9.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/f10308f6-b752-4fcd-8203-cfcd1ecc9611.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/14d2a3c1-520c-4238-9bcc-19a96acc366f.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/7b926ffe-535a-463e-a84e-5e5259b60985.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/b68ba47e-a13a-4018-8b73-3df2805ed0d6.jpeg']::text[], NULL, true, '2026-11-07T12:01:56.335019+00:00', '2026-11-08T04:12:15.270962+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    '93e87c9c-deba-4d9f-8605-642957957822', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'rediam lure', 'rediam lure
40grn 50 grm 
wite color 
red and silver', 1200.0, 250, 'physical', '[]'::jsonb, ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/c41ee88d-6b3b-4fc2-aa03-dd632e296bf6.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/dba17a16-54d3-49b6-a7d4-f2eabf255b62.png']::text[], NULL, true, '2026-11-07T12:14:12.531958+00:00', '2026-11-08T04:12:12.186851+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    '1fb4de3b-fc72-40c6-ac80-7952da30a1ba', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'POPPER frog lure ', '🐸🔥 **අලුත්ම POPPER FROG LURE එක දැන් අපෙන්!** 🎣

දිය මතුපිට මාළු අල්ලන අයට සුපිරි තේරීමක්! 😍🐟

✅ Topwater Action 💦
✅ තියුණු Hook එකක් 🎯
✅ සැහැල්ලු සහ ශක්තිමත් 💪
✅ ආකර්ෂණීය වර්ණ 🔥

💰 **මිල රු. 750/- පමණයි!** 😱❤️

📦 දිවයින පුරා Delivery 🚚🇱🇰

🏪 **IBBAGAMUWA FISHING CENTER**
📍 Dambulla Road, Thorayaya, Kurunegala

📲 ඇණවුම් කිරීමට දැන්ම අපට Message එකක් දාන්න! ❤️', 750.0, 250, 'physical', '[]'::jsonb, ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/485be73c-63ce-4faa-bd35-08f04e6398e0.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/7870d247-6b7a-41ae-a285-04bd5d785f62.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/f47bcfe4-4a0d-4365-9884-741a66e67029.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/fae60998-27f3-44f8-a948-bc5698629901.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/fe12e52f-1340-4ff2-a8e5-1dafc8960397.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/4ec141ae-3dae-4acc-8318-acbbc8ebea03.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/4918e79b-1750-4db7-b756-5c7af3db4ee8.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/bdd347a2-bfbd-48f5-b410-188e0ba734fb.jpeg']::text[], NULL, true, '2026-11-07T12:37:33.431314+00:00', '2026-11-08T04:11:53.320708+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    'a4abd913-cb0b-4176-a938-6c72e6a89935', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'frog lure', '🐸💛 **FROG LURE – සුපිරිම Fishing Lure එකක්!** 🎣🔥

මාළු අල්ලන වැඩේට අලුත්ම ආකර්ෂණීය Frog Lure එක දැන් අපෙන්! 😍

✅ ආකර්ෂණීය Yellow Colour 💛
✅ ශක්තිමත් Double Hooks
✅ Snakehead Fishing සඳහා සුදුසුයි 🐟
✅ පහසු භාවිතය සහ සුපිරි නිමාව

💰 **විශේෂ මිල රු. 750/- පමණයි!** 🔥

📦 දිවයින පුරා Delivery පහසුකම් ඇත.

🏪 **IBBAGAMUWA FISHING CENTER** 🎣', 650.0, 250, 'physical', '[]'::jsonb, ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/1268f4bd-de68-4d76-971d-75aec0bb9e26.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/f3af8bed-859e-4c58-b2dc-fb7523d5a4b2.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/616fd4f9-7878-417d-bbc3-e6ea3eae7de8.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/eaada3d7-59d3-48ca-897e-b702d5b0e8bb.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/6d606b50-12fa-41e8-b5a5-a902380a756e.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/c7f22c65-e27d-4eaf-9f4e-d343b38e98f6.jpeg']::text[], NULL, true, '2026-11-07T12:38:51.160252+00:00', '2026-11-08T04:11:57.08698+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    'bda767de-323a-4853-a15c-bd8d27217f17', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'Long float ', 'Long fishing float / ඉපියා / Float (LKR 200)', 200.0, 0, 'physical', '[]'::jsonb, ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/12392f54-8073-4869-a80e-b2c994b597df.png']::text[], NULL, true, '2026-11-07T13:31:47.765749+00:00', '2026-11-08T04:12:00.15575+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    '7918bb35-3a31-49ba-9b2f-81cbe10a4047', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'FISHING CABLE ', 'High quality fishing wire cable trace (LKR 250) - ශක්තිමත් ෆිෂිං වයර් කේබල්', 250.0, 0, 'physical', '[]'::jsonb, ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/1971ff01-f42b-4479-a6b4-d85838bef74b.png', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/e6c0171f-59f6-413e-ab46-c7ff0bab3b64.png']::text[], NULL, true, '2026-11-07T13:35:10.980572+00:00', '2026-11-08T04:12:03.13068+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    '8e0938f1-8079-4ed8-a65c-586997547d5a', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'Soft Bite Lure ', '
🎣🐟 මාළු අල්ලන වැඩේ තවත් පහසු කරගන්න සුපිරි Soft Bite Lure එකක්! 🔥

✨ ආකර්ෂණීය වර්ණ
💪 මාළුන් ආකර්ෂණය කරන නිර්මාණය
🎯 විශේෂ මසුන් ඇල්ලීම සඳහා

📦 1 Packet – 4 PCS

💰 මිල රු. 1,900/- පමණයි!

📲 අදම ඇණවුම් කරන්න!

', 1900.0, 250, 'physical', '[]'::jsonb, ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/ee47ad4c-c115-46fd-b3e5-039cd23f2e36.png', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/279ace93-f84f-40b7-b9b5-05314d2c2133.png', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/fca8746b-e823-46c3-9ed4-f5b3cdf43635.png', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/607f287a-9fc2-4616-a0bc-63f4c8adc2ba.png', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/9d56fb87-fecd-48a3-ac91-c78173c83ce8.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/cfd7b397-48be-4f67-81df-156fe72b8d15.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/02cdcc7e-c5cb-4e49-9116-8fb4b2a61f14.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/a72d739c-1929-4d99-8a2d-15d3ca8e710b.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/f1aad334-7ba1-4082-9d65-2249bba494ec.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/6f173233-7f33-4fc0-9ed5-5467a318e40b.png']::text[], NULL, true, '2026-11-07T17:59:54.885419+00:00', '2026-11-08T04:12:06.083103+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    'b5075f6f-3e47-4ce2-a7ba-0fcf0ff29ab1', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'lure set with tackle box', '🎣🔥 සුපිරි LURE SET එකක් දැන් ඔබටම!

🐟 14g LURE 5ක්
📦 පහසුකම් සහිත TACKLE BOX එකක් සමඟින්

💰 මිල රු. 1,900/- පමණයි!

🔥 මසුන් දඩයම් කරන ඔබට අනිවාර්යයෙන්ම තිබිය යුතු SET එකක්!

📍 Ibbagamuwa Fishing Center

📲 අදම ඇණවුම් කරන්න!', 1900.0, 250, 'physical', '[]'::jsonb, ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/015f8f73-72b1-4c4c-af4e-af8f883e1961.png']::text[], NULL, true, '2026-11-07T18:27:42.021339+00:00', '2026-11-08T04:12:09.087488+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    '49c75128-3d2b-4486-b1ec-4fc3483b0e60', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'FLOAT IPIYO ', 'sinhala caption tha
🎣🐟 Fishing Float – සුපිරි තත්ත්වයේ බෝබර් එකක්!

🔴 10g Fishing Float
💪 ශක්තිමත් සහ කල්පවතින නිමාව
🎯 ඉහළ දෘශ්‍යතාවයක්
🌊 ජලයේ හොඳින් පාවෙන නිර්මාණය

💰 1ක් රු.150/- පමණයි!

🔥 අදම ඇණවුම් කරන්න!

📍 Ibbagamuwa Fishing Center', 150.0, 0, 'physical', '[]'::jsonb, ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/35e4d38d-fbc2-4c82-8d24-918ca1ce65f1.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/74158333-5f13-44d4-976c-d79299b51822.jpeg', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/54bb62fa-bcdf-4c21-aefb-99b70a962cf2.jpeg']::text[], NULL, true, '2026-11-08T13:04:34.515245+00:00', '2026-11-08T13:09:30.52574+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    '52710284-2d95-430a-8ec4-a98aff2eddb6', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'AC7000 Fishing Reel /rod machine', 'metal reel 
drag kg 5-8
china 
🎣🔥 **සුපිරි Fishing Reel දෙකක් – දැන් විශේෂ මිලකට!**

💥 **AC5000 Fishing Reel** – රු. 2,900/-
💥 **AC7000 Fishing Reel** – රු. 3,900/-

✅ සුපිරි නිමාව
✅ ශක්තිමත් නිර්මාණය
✅ Smooth Performance
✅ මසුන් ඇල්ලීමට කදිමයි 🐟

📦 සීමිත තොගයක් පමණයි!

📍 Ibbagamuwa Fishing Center

📲 අදම Order කරන්න!', 3900.0, 450, 'physical', '[{"name": "size", "options": [{"label": "AC4000", "price": 2500}, {"label": "AC5000", "price": 2900}, {"label": "AC7000", "price": 3900}]}]'::jsonb, ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/f26f037b-6918-4139-9706-7ecc8fe09e59.png', 'https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/50ac2b17-889e-45f2-af0a-1df3a06ec047.png']::text[], NULL, true, '2026-11-08T13:25:51.071504+00:00', '2026-11-08T13:33:23.421024+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    '3d2454eb-9e4b-443e-b5f5-0bc001c4062c', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'HT7000 FISHING REEL', '🎣🔥 **HT7000 Fishing Reel – සුපිරි තත්ත්වයේ Reel එකක්!**

💪 ශක්තිමත් නිමාව
⚙️ 14 Ball Bearings
🐟 මසුන් ඇල්ලීමට කදිම තේරීමක්
✨ Smooth Performance

💰 **විශේෂ මිල රු. 4,900/- පමණයි!**

📦 සීමිත තොගයක් පමණයි!

📍 Ibbagamuwa Fishing Center

📲 අදම ඔබේ ඇණවුම වෙන්කරවා ගන්න!
', 4900.0, 450, 'physical', '[]'::jsonb, ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/7fd0924a-5e76-45bf-888f-731d20304f63.png']::text[], NULL, true, '2026-11-08T13:37:42.591561+00:00', '2026-11-08T13:37:42.591561+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    '68720b46-4cb3-4f3a-82d1-6afc59e391f2', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', 'Fishing Float (ඉපියා)', 'float,ipiyo', 150.0, 0, 'physical', '[]'::jsonb, ARRAY['https://storage.buildstart.io/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/5597eb72-f535-4f48-9984-8c2f42ee097f.jpeg', 'https://storage.buildstart.io/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/cf351202-b6e7-46b1-bc4a-a1c2a3fca37d.jpeg', 'https://storage.buildstart.io/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/65d6348d-e651-4ce2-8f8d-31091912e87e.jpeg']::text[], NULL, true, '2026-11-08T18:32:56.046827+00:00', '2026-11-09T04:40:05.825938+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.products (
    id, user_id, name, description, price, delivery_price, product_type, variations, images, video_url, is_active, created_at, updated_at
) VALUES (
    'e2d7735a-5a70-45cc-8f37-d1ef5a84021d', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', '...', NULL, 150.0, 0, 'physical', '[]'::jsonb, ARRAY['https://storage.buildstart.io/biz-b1120f27-7cd3-4429-a8d3-c678c93b9562/products/a43035eb-a8bf-4c09-abb9-67354f5bba21.jpeg']::text[], NULL, false, '2026-11-08T18:34:46.281516+00:00', '2026-11-09T04:40:05.825938+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    delivery_price = EXCLUDED.delivery_price,
    product_type = EXCLUDED.product_type,
    variations = EXCLUDED.variations,
    images = EXCLUDED.images,
    video_url = EXCLUDED.video_url,
    is_active = EXCLUDED.is_active,
    updated_at = EXCLUDED.updated_at;


-- 2. Insert FAQs
INSERT INTO ibbagamuwa_customization.faqs (
    id, user_id, product_id, question, answer, is_active, is_tracked, media_urls, created_at, updated_at
) VALUES (
    '733d91ab-b68a-4744-bdc6-b8878ad0fba5', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', NULL, 'Do you provide delivery across Sri Lanka?', 'Yes, we offer secure All-Island Delivery to any town or district across Sri Lanka!', true, false, '{}'::text[], '2026-11-05T06:38:40.626548+00:00', '2026-11-05T06:38:40.626548+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    product_id = EXCLUDED.product_id,
    question = EXCLUDED.question,
    answer = EXCLUDED.answer,
    is_active = EXCLUDED.is_active,
    is_tracked = EXCLUDED.is_tracked,
    media_urls = EXCLUDED.media_urls,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.faqs (
    id, user_id, product_id, question, answer, is_active, is_tracked, media_urls, created_at, updated_at
) VALUES (
    'b974f2ef-c81e-4bf4-b067-f3d67cafbcd7', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', NULL, 'What are the available rod heights and sizes?', 'Our fishing rods come in various lengths from 6ft up to 15ft (including 6ft, 7ft, 8ft, 9ft, 10ft, 12ft, and 15ft depending on the model). They feature compact telescopic and 2-piece foldable designs making them very convenient to carry.', true, false, '{}'::text[], '2026-11-05T06:38:55.494366+00:00', '2026-11-07T21:06:32.720347+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    product_id = EXCLUDED.product_id,
    question = EXCLUDED.question,
    answer = EXCLUDED.answer,
    is_active = EXCLUDED.is_active,
    is_tracked = EXCLUDED.is_tracked,
    media_urls = EXCLUDED.media_urls,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.faqs (
    id, user_id, product_id, question, answer, is_active, is_tracked, media_urls, created_at, updated_at
) VALUES (
    '6cc499e9-abcb-4c57-b641-d6f91d4f3c44', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', NULL, 'Can I pay using Cash on Delivery (COD)?', 'Yes! We support Cash on Delivery (COD) so you can pay once the package reaches your doorstep, as well as Bank Transfer.', true, false, '{}'::text[], '2026-11-05T06:39:07.833393+00:00', '2026-11-05T06:39:07.833393+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    product_id = EXCLUDED.product_id,
    question = EXCLUDED.question,
    answer = EXCLUDED.answer,
    is_active = EXCLUDED.is_active,
    is_tracked = EXCLUDED.is_tracked,
    media_urls = EXCLUDED.media_urls,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.faqs (
    id, user_id, product_id, question, answer, is_active, is_tracked, media_urls, created_at, updated_at
) VALUES (
    '8294e45f-f4f2-449d-9dcd-6a61442d7353', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', NULL, 'How long does delivery take?', 'Orders are dispatched promptly and typically delivered within 2 to 4 working days to any location in Sri Lanka.', true, false, '{}'::text[], '2026-11-05T06:39:16.526354+00:00', '2026-11-05T06:39:16.526354+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    product_id = EXCLUDED.product_id,
    question = EXCLUDED.question,
    answer = EXCLUDED.answer,
    is_active = EXCLUDED.is_active,
    is_tracked = EXCLUDED.is_tracked,
    media_urls = EXCLUDED.media_urls,
    updated_at = EXCLUDED.updated_at;

INSERT INTO ibbagamuwa_customization.faqs (
    id, user_id, product_id, question, answer, is_active, is_tracked, media_urls, created_at, updated_at
) VALUES (
    '9eb026fd-0aa8-4cd5-80db-1f8d9227bbb5', 'b1120f27-7cd3-4429-a8d3-c678c93b9562', NULL, 'What other fishing equipment do you have? Do you sell cast nets (Wisi Del)?', 'We specialize in complete fishing packages (combo kits), rods, spinning/baitcasting reels, braided/monofilament lines, lures, frogs, and hooks. Please contact us directly regarding cast net (wisi del) availability.', true, false, '{}'::text[], '2026-11-05T06:39:27.686345+00:00', '2026-11-05T06:39:27.686345+00:00'
) ON CONFLICT (id) DO UPDATE SET
    user_id = EXCLUDED.user_id,
    product_id = EXCLUDED.product_id,
    question = EXCLUDED.question,
    answer = EXCLUDED.answer,
    is_active = EXCLUDED.is_active,
    is_tracked = EXCLUDED.is_tracked,
    media_urls = EXCLUDED.media_urls,
    updated_at = EXCLUDED.updated_at;
