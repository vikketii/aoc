DROP TABLE IF EXISTS crates;

WITH chars AS (
  -- Get crates
  SELECT
    4 - id AS y,
    string_to_table (regexp_replace(inputs, '\s{3}|[\[\]]', '', 'g'), ' ', '') AS crate FROM d05
      WHERE
        id < (
          SELECT
            id
          FROM d05
          WHERE
            inputs = '') - 1),
    crates AS (
      SELECT
        mod(row_number() OVER () - 1, 3) + 1 AS x,
        y,
        crate
      FROM
        chars
)
      SELECT
        x,
        y,
        crate INTO crates
      FROM
        crates
      WHERE
        crate IS DISTINCT FROM NULL;

DROP TABLE IF EXISTS instructions;

WITH base AS (
  -- Get instructions
  SELECT
    (regexp_split_to_array(inputs, 'move | from | to ')) AS instructions
  FROM
    d05
  WHERE
    id > (
      SELECT
        id
      FROM
        d05
      WHERE
        inputs = ''))
SELECT
  row_number() OVER () AS i,
  instructions[2]::int n,
  instructions[3]::int a,
  instructions[4]::int b INTO TEMP instructions
FROM
  base;

-- CREATE OR REPLACE FUNCTION myfunc (IN i int, IN v int, OUT y int)
-- LANGUAGE sql
-- AS $$
--   WITH RECURSIVE asdf (
--     n
-- ) AS (
--     VALUES (1)
--     UNION ALL
--     SELECT
--       n + 1
--     FROM
--       asdf
--     WHERE
--       n < 3
-- )
--   SELECT
--     *
--   FROM
--     asdf;
-- $$;
-- DROP FUNCTION myfunc (int, int, int);
-- CREATE OR REPLACE FUNCTION myfunc (IN n int, IN a int, IN b int, OUT x int, OUT y int, OUT crate text)
-- LANGUAGE sql
-- AS $$
--   -- INSERT INTO crates (crate)
--   SELECT
--     x,
--     y,
--     crate
--   FROM
--     crates
--   WHERE
--     x = a
--     AND y = (
--       SELECT
--         max(y)
--       FROM
--         crates
--       WHERE
--         x = a)
--     -- RETURNING
--     -- 1
-- $$;
SELECT
  *
FROM
  crates;

SELECT
  *
FROM
  instructions;

-- INSERT INTO crates (crate)
-- SELECT
--   'X'
-- FROM
--   instructions AS ins,
--   LATERAL (
--     SELECT
--       crate
--     FROM
--       crates
--     WHERE
--       x = a
--       AND y = (
--         SELECT
--           max(y)
--         FROM
--           crates
--         WHERE
--           x = a)) AS cra;
-- (
--   SELECT
--     crate
--   FROM
--     instructions AS ins,
--     LATERAL (
--       SELECT
--         crate
--       FROM
--         crates
--       WHERE
--         x = a
--         AND y = (
--           SELECT
--             max(y)
--           FROM
--             crates
--           WHERE
--             x = a)) AS cra);
WITH RECURSIVE working (
  n, x, y, crate
) AS (
  SELECT 1, x, y, crate FROM crates
  UNION ALL
  SELECT n + 1, 0, 0, 'X'
  FROM
    instructions
  WHERE
    n < i)
SELECT
  *
FROM
  working;

-- UPDATE employees SET sales_count = sales_count + 1 WHERE id =
--   (SELECT sales_person FROM accounts WHERE name = 'Acme Corporation');
