with mapped_pages as (

    select
      b.universal_alias,
      a.*

    from {{ ref(segment_pages) }} a
    left join {{ ref(segment_universal_user_id) }} b
      on a.anonymous_id = b.alias

)

select * from mapped_pages
