WITH RECURSIVE 
  -- Let's first get crate stacks as strings
    temp_crates AS (
    SELECT 
        id,
        string_to_table(
            regexp_replace(
                regexp_replace(
                    regexp_replace(
                        inputs, '[\[\]]', '', 'g'
                    ), '\s{4}', '-', 'g'
                ), '\s', '', 'g'
            ), NULL, '-'
        ) AS crate
    FROM d05
    WHERE id < (SELECT id FROM d05 WHERE inputs = '') - 1
), temp_crates_2 AS (
    SELECT
        id,
        crate,
        mod(row_number() OVER () - 1, 9) AS stack_num        
    FROM temp_crates
), crates AS (
    SELECT 
        stack_num, 
        STRING_AGG(crate, '' ORDER BY id DESC) AS stack
    FROM temp_crates_2
    WHERE crate != ''
    GROUP BY stack_num ORDER BY stack_num
),
    -- Then instructions where count, source and destination are in separate columns
    temp_ins AS (
    SELECT regexp_split_to_array(inputs, 'move | from | to ') AS vals
    FROM d05
    WHERE id > (SELECT id FROM d05 WHERE inputs = '')
), instructions AS (
    SELECT
        row_number() OVER () AS x,
        vals[2]::int count, vals[3]::int src, vals[4]::int dest
    FROM temp_ins
),
    -- Now to the good part, moving crates with recursion
    stacks AS (
    SELECT
        0 AS x,
        ARRAY_AGG(stack ORDER BY stack_num) AS stack_array -- Array of initial stacks (as strings)
    FROM crates
    UNION ALL
    -- for each instruction (match with recursion move number)
    SELECT 
        s.x + 1 AS x,
        
        -- for each stack in the stack array:
        --   if stack number corresponds to instruction src or dest number:
        --     either remove letters from stack or add from src stack (reversed)
        --   else: return current stack
        (
            SELECT ARRAY_AGG(
                CASE i
                    WHEN ins.src THEN LEFT(stack, LENGTH(stack) - ins.count)
                    -- WHEN ins.dest THEN stack || REVERSE(RIGHT(stack_array[ins.src], ins.count)) -- part 1
                    WHEN ins.dest THEN stack || RIGHT(stack_array[ins.src], ins.count) -- part 2
                    ELSE stack
                END
            )
            FROM UNNEST(stack_array) WITH ORDINALITY AS a(stack, i)
        ) AS arr
    FROM stacks s JOIN instructions ins ON (ins.x = s.x + 1)
)
-- Get the topmost crate on each stack
SELECT 
    STRING_AGG(RIGHT(stack, 1), '') as part_x
FROM 
    stacks s,
    UNNEST(s.stack_array) AS stack
WHERE x = (SELECT MAX(x) FROM stacks);
