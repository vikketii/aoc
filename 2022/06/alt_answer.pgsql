-- After doing my initial solution I try to improve my answer
-- with other solutions to learn better SQL Fu.
-- This one is from github.com/passcod/adventofcode22
--
-- Part 1
WITH signals AS (
    -- Input chars as table
    SELECT
        string_to_table (inputs, NULL) AS s
    FROM
        d06
),
s_groups AS (
    -- Make groups of four from all chars and add index
    SELECT
        row_number() OVER () AS i,
        array_agg(s) OVER (ROWS 3 PRECEDING) AS s_array
    FROM
        signals
),
results AS (
    -- Skip first short groups and take then only the groups having 4 unique values
    SELECT
        *
    FROM
        s_groups
    WHERE
        i > 3
        AND (
            SELECT
                count(*)
            FROM ( SELECT DISTINCT
                    unnest(s_array)) t) = 4)
    -- Select first result as our answer
    SELECT
        i AS part_1
    FROM
        results
    LIMIT 1;

-- Part two is the same except we change the window length
WITH signals AS (
    SELECT
        string_to_table (inputs, NULL) AS s
    FROM
        d06
),
s_groups AS (
    SELECT
        row_number() OVER () AS i,
        array_agg(s) OVER (ROWS 13 PRECEDING) AS s_array
    FROM
        signals
),
results AS (
    SELECT
        *
    FROM
        s_groups
    WHERE
        i > 13
        AND (
            SELECT
                count(*)
            FROM ( SELECT DISTINCT
                    unnest(s_array)) t) = 14
)
SELECT
    i AS part_2
FROM
    results
LIMIT 1;
