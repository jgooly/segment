with realiases as (

    select
      anonymous_id as alias,
      user_id      as next_alias

    from {{ ref('segment_pages') }}
)

select distinct
  r0.alias,
  coalesce(r1.next_alias, r1.alias, r0.alias) as universal_alias

from realiases r0
  left join realiases r1 on r0.alias = r1.alias
