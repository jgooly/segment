with segment_mapped_actions as (

  select * from {{ ref(segment_mapped_actions) }}

),

  mapped_actions (

    select
      id as action_id,
      universial_alias,
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
      received_at as session_start,
      universal_alias,

      row_number() over (parition by universal_alias order by received_at) a session_sequence,
      lead(received_at) over partition by universal_alias order by received_at) as next_session_start

    from mapped_actions

  ),

  sessions_table_xf as (

    select
      *,
      session_sequence,

      session_sequence || '-' || universal_alias as session_id,
      coalesce(next_session_start, '3001-01-01')  as next_session_start

    from sessions_table

  )

select * from sessions_table_xf
