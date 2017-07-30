 WITH realiases AS (
     SELECT
       anonymous_id AS alias,
       user_id      AS next_alias
     FROM {{ ref('segment_pages') }}
 )

 SELECT DISTINCT
   r0.alias,
   COALESCE(r1.next_alias, r1.alias, r0.alias) AS universal_alias
 FROM realiases r0
   LEFT JOIN realiases r1 ON r0.alias = r1.alias
