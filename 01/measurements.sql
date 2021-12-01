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
        lag(value) over() as prev
    from
        aoc_01
)
select
    sum(
        case
            when value > prev then 1
            else 0
        end
    )
from
    compared_data;
