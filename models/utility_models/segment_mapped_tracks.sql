with mapped_tracks as (

    select
      b.universal_alias,
      a.*

    from {{ ref(segment_tracks) }} a
    left join {{ ref(segment_universal_user_id) }} b
    on a.anonymous_id = b.alias

)

select * from mapped_tracks
