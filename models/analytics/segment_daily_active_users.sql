SELECT 
	date(session_start) as _date,
	count(DISTINCT universal_alias) as dau_count
FROM  {{ ref(segment_sessions) }}
GROUP BY date(session_start)
ORDER BY date DESC