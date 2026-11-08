-- ============================================================================
-- 03_cron_filled.sql — scheduled jobs (safety net + follow-ups).
-- Requires pg_cron + pg_net. Run as superuser on your self-hosted Postgres.
-- ============================================================================

CREATE EXTENSION IF NOT EXISTS pg_cron;
CREATE EXTENSION IF NOT EXISTS pg_net;

-- Clear previous jobs if any
DO $$
BEGIN
  PERFORM cron.unschedule('drain-message-queue') WHERE EXISTS (SELECT 1 FROM cron.job WHERE jobname = 'drain-message-queue');
  PERFORM cron.unschedule('send-followups') WHERE EXISTS (SELECT 1 FROM cron.job WHERE jobname = 'send-followups');
  PERFORM cron.unschedule('drain-message-queue_fishing_V2') WHERE EXISTS (SELECT 1 FROM cron.job WHERE jobname = 'drain-message-queue_fishing_V2');
  PERFORM cron.unschedule('send-followups_fishing_V2') WHERE EXISTS (SELECT 1 FROM cron.job WHERE jobname = 'send-followups_fishing_V2');
  PERFORM cron.unschedule('drain-message-queue-ibbagamuwa') WHERE EXISTS (SELECT 1 FROM cron.job WHERE jobname = 'drain-message-queue-ibbagamuwa');
  PERFORM cron.unschedule('send-followups-ibbagamuwa') WHERE EXISTS (SELECT 1 FROM cron.job WHERE jobname = 'send-followups-ibbagamuwa');
EXCEPTION WHEN OTHERS THEN
  NULL;
END $$;

-- Queue drainer safety net. webhook-wsender already fires process-message
-- immediately on each inbound message; this catches anything left behind.
SELECT cron.schedule(
  'drain-message-queue-ibbagamuwa',
  '* * * * *',
  $$
  SELECT net.http_post(
    url     := 'http://api-gw:8000/functions/v1/process-message-ibbagamuwa',
    headers := '{"Content-Type":"application/json","Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoic2VydmljZV9yb2xlIiwiaXNzIjoic3VwYWJhc2UiLCJpYXQiOjE3OTM2MjQ0NTAsImV4cCI6MjEwODk4NDQ1MH0.3NSKKo_lwbQZHiQEfmH_WIzO-acB0Y0hEQErOB9yDWs"}'::jsonb,
    body    := '{"trigger":"cron"}'::jsonb
  );
  $$
);

-- Order follow-ups + inactivity follow-ups.
SELECT cron.schedule(
  'send-followups-ibbagamuwa',
  '*/5 * * * *',
  $$
  SELECT net.http_post(
    url     := 'http://api-gw:8000/functions/v1/send-followups-ibbagamuwa',
    headers := '{"Content-Type":"application/json","Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoic2VydmljZV9yb2xlIiwiaXNzIjoic3VwYWJhc2UiLCJpYXQiOjE3OTM2MjQ0NTAsImV4cCI6MjEwODk4NDQ1MH0.3NSKKo_lwbQZHiQEfmH_WIzO-acB0Y0hEQErOB9yDWs"}'::jsonb,
    body    := '{}'::jsonb
  );
  $$
);

-- Inspect:  SELECT jobid, jobname, schedule FROM cron.job;
-- Remove:   SELECT cron.unschedule('drain-message-queue-ibbagamuwa');
