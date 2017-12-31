with segment_mapped_action as (

  select * from {{ ref('segment_mapped_actions') }}

),

  segment_sessions as (

    select * from {{ ref('segment_sessions') }}

  ),

    mapped_actions as (

      select
        a.received_at,
        a.id,
        a.path,
        a.name,
        a.action_type,
        b.universial_alias,
        b.session_id

      from segment_mapped_action a
        inner join segment_sessions b
          on a.universal_alias = b.universial_alias
             and a.received_at >= b.session_start
             and a.received_at < b.next_session_start
  )

select
  *,

  row_number() over (partition by session_id order by received_at) as action_sequence

from mapped_actions
