SELECT
  id,
  received_at,
  timestamp,
  anonymous_id,
  user_id,
  name,
  category,
  path,
  url,
  title,
  context_page_referrer as referrer,
  search,
  context_campaign_name,
  context_campaign_content,
  context_campaign_medium,
  context_campaign_source,
  context_campaign_term,
  context_user_agent
from
  {{ var('base.pages') }}