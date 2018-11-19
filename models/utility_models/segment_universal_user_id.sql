with segment_pages as (

    select * from {{ ref('segment_pages') }}
    where anonymous_id is not null

),

  segment_tracks as (

    select * from {{ ref('segment_tracks') }}

  ),

  segment_identifies as (

    select * from {{ ref('segment_identifies') }}
    where anonymous_id is not null

  ),

  unioned as (

      select
        anonymous_id,
        user_id,
        received_at

      from segment_pages

      union

      select
        anonymous_id,
        user_id,
        received_at

      from segment_tracks
      where anonymous_id is not null

      union

      select
        user_id as anonymous_id,
        user_id,
        received_at

      from segment_tracks
      where user_id is not null

      union

      select
        anonymous_id,
        user_id,
        received_at

      from segment_identifies

  ),

sequenced as (
  select distinct
    unioned.anonymous_id,
    last_value(case when user_id is null then null else unioned.anonymous_id end ignore nulls)
      over (partition by user_id order by received_at asc
            rows between unbounded preceding and unbounded following) as last_anonymous_id,
    last_value(unioned.user_id ignore nulls)
      over (partition by anonymous_id order by received_at asc
            rows between unbounded preceding and unbounded following) as user_id

  from unioned
),

coalesced as (

  select
    sequenced.anonymous_id as alias,
    nvl(parents.user_id, sequenced.last_anonymous_id, sequenced.anonymous_id) as universal_alias,
    case
      when parents.user_id is not null then 3
      when sequenced.last_anonymous_id is not null then 2
      when sequenced.anonymous_id is not null then 1
      else null
    end as alias_type
  from
    sequenced
    left join sequenced as parents on sequenced.last_anonymous_id = parents.anonymous_id

),

final as (

  select distinct
    alias,
    first_value(universal_alias ignore nulls)
      over (partition by alias
            order by alias_type desc nulls last,
                      universal_alias desc nulls last
            rows between unbounded preceding and unbounded following
            ) as universal_alias

  from
    coalesced
)

select * from final
