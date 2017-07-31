SELECT
  a.received_at,
  a.id,
  a.path,
  a.name,
  a.action_type,
  b.user_id,
  b.session_id,
  ROW_NUMBER()
  OVER (PARTITION BY session_id ORDER BY received_at) AS action_sequence
FROM {{ ref(segment_sessions_mapped_actions) }}       AS a
  INNER JOIN {{ ref(segment_sessions) }}              AS b
    ON a.universal_alias = b.universal_alias
       AND a.received_at >= b.session_start
       AND a.received_at < b.next_session_start