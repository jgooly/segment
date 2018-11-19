with base_identifies as (

    select * from {{ var('base.identifies') }}

)

select
  id,

  {{ var('created_at') }} as created_at,
  {{ var('received_at') }} as received_at,

  "timestamp",

  anonymous_id,
  user_id,
  {{ var('locale') }} as locale

from base_identifies
