-- Migration: Standardize Yomoshi BM5000 reel and add structured variations
-- Schema: ibbagamuwa_customization

DO $$
DECLARE
    v_updated_count INT := 0;
    v_owner_id UUID;
BEGIN
    -- Check if target table exists
    IF EXISTS (
        SELECT 1 FROM information_schema.tables 
        WHERE table_schema = 'ibbagamuwa_customization' AND table_name = 'products'
    ) THEN
        -- 1. Try to update existing record by name pattern
        UPDATE ibbagamuwa_customization.products
        SET 
            name = 'Yomoshi BM5000 Metal Spinning Reel',
            price = 6500.00,
            delivery_price = COALESCE(delivery_price, 450.00),
            variations = '[{"name": "Size", "options": [{"label": "BM5000", "price": 6500}]}]'::jsonb,
            description = 'High quality Yomoshi BM5000 metal spinning reel (5000 series). High strength metal spool, smooth gear ratio, and balanced rotor. Price: LKR 6,500. Available individually.'
        WHERE name ILIKE '%yomoshi%' 
           OR name ILIKE '%BM5THOUSANND%'
           OR name ILIKE '%metel reel%';
        
        GET DIAGNOSTICS v_updated_count = ROW_COUNT;
        
        -- 2. If not found (e.g. fresh local database), insert it cleanly
        IF v_updated_count = 0 THEN
            SELECT user_id INTO v_owner_id FROM ibbagamuwa_customization.products LIMIT 1;
            IF v_owner_id IS NOT NULL THEN
                INSERT INTO ibbagamuwa_customization.products (
                    id,
                    user_id,
                    name,
                    description,
                    price,
                    delivery_price,
                    product_type,
                    variations,
                    images,
                    is_active
                ) VALUES (
                    'a8f10284-2d95-430a-8ec4-a98aff2eddb9',
                    v_owner_id,
                    'Yomoshi BM5000 Metal Spinning Reel',
                    'High quality Yomoshi BM5000 metal spinning reel (5000 series). High strength metal spool, smooth gear ratio, and balanced rotor. Price: LKR 6,500. Available individually.',
                    6500.00,
                    450.00,
                    'physical',
                    '[{"name": "Size", "options": [{"label": "BM5000", "price": 6500}]}]'::jsonb,
                    ARRAY['https://supabase.buildstart.io/storage/v1/object/public/biz-5543a79b-21f1-4091-905b-025d39acd0c8/products/yomoshi-bm5000.jpg']::text[],
                    true
                );
            END IF;
        END IF;
    END IF;
END $$;

