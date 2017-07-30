SELECT
  id AS user_id,
  received_at,
  created_at,
  locale,
  context_campaign_medium,
  context_campaign_name,
  context_campaign_source,
  context_campaign_content,
  context_campaign_term
FROM
  {{ ref('base.users') }}