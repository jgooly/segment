with segment_tracks as (

  select * from {{ ref(segment_tracks) }}

),

  segment_universal_user_id as (

    select * from {{ ref(segment_universal_user_id) }}

  ),

  mapped_tracks as (

    select
      b.universal_alias,
      a.*

    from segment_tracks a
      left join segment_universal_user_id b on a.anonymous_id = b.alias

)

select * from mapped_tracks
