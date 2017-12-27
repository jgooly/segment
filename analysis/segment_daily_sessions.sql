with segment_sessions as (

    select * from {{ ref('segment_sessions') }}

)

select
  date(session_start)        as _date,

  count(distinct session_id) as count

from segment_sessions
group by date(session_start)
order by _date desc
