with base_tracks as (

    select * from {{ var('base.tracks') }}

)

select
  id,
  received_at,
  timestamp,
  anonymous_id,
  user_id,
  event,
  event_text,
  context_page_path        as path,
  context_page_url         as url,
  context_page_title       as title,
  context_page_referrer    as referrer,
  context_page_search      as search,
  context_campaign_name    as campaign_name,
  context_campaign_content as campaign_content,
  context_campaign_medium  as campaign_medium,
  context_campaign_source  as campaign_source,
  context_campaign_term    as campaign_term,
  context_user_agent

from base_tracks
