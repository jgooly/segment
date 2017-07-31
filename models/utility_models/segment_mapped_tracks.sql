m_tracks AS (
    SELECT
      b.universal_alias,
      a.*
    FROM {{ ref(segment_tracks) }} a
           LEFT JOIN {{ ref(segment_universal_user_id) }} b
           ON a.anonymous_id = b.alias
)

SELECT * FROM m_tracks
