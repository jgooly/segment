with base_identifies as (

    select * from {{ var('base.identifies') }}

)

select
  id,
  received_at,
  timestamp,
  created_at,
  anonymous_id,
  user_id,
  locale

from base_identifies