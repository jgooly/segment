with segment_pages as (

  select * from {{ ref(segment_pages) }}

),

  segment_universal_user_id as (

    select * from {{ ref(segment_universal_user_id) }}

  ),

  mapped_pages as (

    select
      b.universal_alias,
      a.*

    from segment_pages a
      left join segment_universal_user_id b on a.anonymous_id = b.alias

)

select * from mapped_pages
