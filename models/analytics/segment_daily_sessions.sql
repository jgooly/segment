SELECT
  date(session_start)        AS _date,
  count(DISTINCT session_id) AS count
FROM {{ ref(segment_sessions) }}
GROUP BY date(session_start)
ORDER BY _date DESC