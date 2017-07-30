SELECT
  id,
  received_at,
  a.timestamp,
  created_at,
  anonymous_id,
  user_id,
  locale
FROM
  {{ ref('base.identifies') }} a