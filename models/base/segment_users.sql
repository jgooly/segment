with base_users as (

    select * from {{ var('base.users') }}

)

select
  id as user_id,
  received_at,
  created_at,
  locale,
  context_campaign_medium,
  context_campaign_name,
  context_campaign_source,
  context_campaign_content,
  context_campaign_term

from base_users