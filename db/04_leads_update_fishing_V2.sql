-- ============================================================================
-- 04_leads_update_fishing_V2.sql
-- Upgrade leads table for Ibbagamuwa FishingHub PRD compliance:
-- Adds location, district, package_interest, timeline, payment preference, and custom fields.
-- Compatible with both fishing_v2 and public schemas.
-- ============================================================================

DO $$
BEGIN
    -- 1. fishing_v2 schema
    IF EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'fishing_v2') THEN
        ALTER TABLE fishing_v2.leads
            ADD COLUMN IF NOT EXISTS location text,
            ADD COLUMN IF NOT EXISTS district text,
            ADD COLUMN IF NOT EXISTS package_interest text,
            ADD COLUMN IF NOT EXISTS quantity integer DEFAULT 1,
            ADD COLUMN IF NOT EXISTS purchase_timeline text,
            ADD COLUMN IF NOT EXISTS payment_preference text,
            ADD COLUMN IF NOT EXISTS qualification_notes text,
            ADD COLUMN IF NOT EXISTS custom_fields jsonb DEFAULT '{}'::jsonb;

        -- Update default status
        ALTER TABLE fishing_v2.leads ALTER COLUMN status SET DEFAULT 'new_inquiry';

        -- Normalize any existing 'new' to 'new_inquiry'
        UPDATE fishing_v2.leads SET status = 'new_inquiry' WHERE status = 'new';
    END IF;

    -- 2. public schema
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'leads') THEN
        ALTER TABLE public.leads
            ADD COLUMN IF NOT EXISTS location text,
            ADD COLUMN IF NOT EXISTS district text,
            ADD COLUMN IF NOT EXISTS package_interest text,
            ADD COLUMN IF NOT EXISTS quantity integer DEFAULT 1,
            ADD COLUMN IF NOT EXISTS purchase_timeline text,
            ADD COLUMN IF NOT EXISTS payment_preference text,
            ADD COLUMN IF NOT EXISTS qualification_notes text,
            ADD COLUMN IF NOT EXISTS custom_fields jsonb DEFAULT '{}'::jsonb;

        ALTER TABLE public.leads ALTER COLUMN status SET DEFAULT 'new_inquiry';
        UPDATE public.leads SET status = 'new_inquiry' WHERE status = 'new';
    END IF;
END $$;

