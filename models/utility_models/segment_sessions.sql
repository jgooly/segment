WITH m_p AS (
    SELECT
      id                                    AS action_id,
      universal_alias,
      received_at,
      DATEDIFF(minutes, LAG(received_at)
      OVER (PARTITION BY universal_alias
        ORDER BY received_at), received_at) AS idle_time
    FROM {{ ref(segment_mapped_actions) }}
),

sessions_table AS (
    SELECT
      lag.universal_alias,
      ROW_NUMBER()
      OVER (PARTITION BY lag.universal_alias
        ORDER BY lag.received_at) || '-' || lag.universal_alias AS session_id,
      lag.received_at                                           AS session_start,
      ROW_NUMBER()
      OVER (PARTITION BY lag.universal_alias
        ORDER BY lag.received_at)                               AS session_sequence,
      COALESCE(LEAD(lag.received_at)
               OVER (PARTITION BY lag.universal_alias
                 ORDER BY lag.received_at),
               '3000-01-01')                                    AS next_session_start
    FROM m_p AS lag
    WHERE (lag.idle_time > 30 OR lag.idle_time IS NULL)
)

SELECT * FROM sessions_table
