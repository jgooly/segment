select
  a.universal_alias,
  a.id,
  a.received_at,
  a.path,
  a.name,
  'page' as action_type

from {{ ref(segment_mapped_pages) }} a

union all

select
  b.universal_alias,
  b.id,
  b.received_at,
  b.context_page_path as path,
  b.event_text        as name,
  'track'             as action_type

from {{ ref(segment_mapped_tracks) }} b
