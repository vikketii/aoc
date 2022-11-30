drop table if exists aoc_01;

create table aoc_01 (value int);

-- insert into
--     aoc_01 (value)
-- values
--     (199),
--     (200),
--     (208),
--     (210),
--     (200),
--     (207),
--     (240),
--     (269),
--     (260),
--     (263);

\copy aoc_01 from 'input'

with compared_data as (
    select
        value,
        lag(value) over() as prev1,
        lag(value, 2) over() as prev2,
        lag(value, 3) over() as prev3
    from
        aoc_01
)
select
    sum(
        case
            when value > prev1 then 1
            else 0
        end
    ) as part1,
    sum(
        case
            when (value + prev1 + prev2) > (prev1 + prev2 + prev3) then 1
            else 0
        end
    ) as part2
from
    compared_data;
