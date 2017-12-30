with segment_mapped_actions as (

  select * from {{ ref('segment_mapped_actions') }}

),

  mapped_actions as (

    select
      id as action_id,
      universial_alias as user_id,
      received_at,
      lag(received_at) over (partition by universal_alias order by received_at) as last_received_at

    from segment_mapped_actions

  ),

  mapped_actions_xf as (

  select
    *,

    datediff(minutes, last_received_at, received_at) as idle_time

  from mapped_actions

  ),

sessions_table as (

  select
    ma.user_id,
    ma.received_at as session_start,

    row_number() over (partition by ma.user_id
      order by ma.received_at) || '-' || ma.user_id as session_id,
    
    row_number() over (partition by ma.user_id
      order by ma.received_at) as session_sequence,

    coalesce(
      lead(ma.received_at)
        over (partition by ma.user_id order by ma.received_at), '3000-01-01') as next_session_start

  from mapped_actions_xf as ma
  where (ma.idle_time > 30 or ma.idle_time is null)

)

select * from sessions_table
