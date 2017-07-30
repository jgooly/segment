SELECT
  id,
  received_at,
  a.timestamp,
  anonymous_id,
  user_id,
  event,
  event_text,
  context_page_path AS path,
  context_page_url AS url,
  context_page_title AS title,
  context_page_referrer AS referrer,
  context_page_search AS search,
  context_campaign_name AS campaign_name,
  context_campaign_content AS campaign_content,
  context_campaign_medium AS campaign_medium,
  context_campaign_source AS campaign_source,
  context_campaign_term AS campaign_term,
  context_user_agent
FROM
  {{ var(' base.tracks') }} a
