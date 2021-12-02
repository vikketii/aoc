drop table if exists aoc_02;

create table aoc_02 
    (
        id serial,
        direction text,
        distance int
    );

-- insert into
--     aoc_02 (direction, distance)
-- values
--     ('forward', 5),
--     ('down', 5),
--     ('forward', 8),
--     ('up', 3),
--     ('down', 8),
--     ('forward', 2);

\copy aoc_02 (direction, distance) from 'input' with delimiter E' '

create type submarine as (
    x int,
    y int,
    aim int
);


create or replace function step(
    s submarine,
    direction text,
    distance integer
) returns submarine as $$
    select
        case
            when direction = 'forward' then (s.x + distance, s.y, s.aim + distance * s.y)::submarine
            when direction = 'down' then (s.x, s.y + distance, s.aim)::submarine
            when direction = 'up' then (s.x, s.y - distance, s.aim)::submarine
        end;
$$ language sql;

create or replace aggregate depth (text, integer) (
    sfunc = step,
    stype = submarine,
    initcond = '(0, 0, 0)'
);


with result as (
    select
        depth(direction, distance) as sub
    from aoc_02
)
select
    (sub).x * (sub).y as part1,
    (sub).x * (sub).aim as part2
from result;
    
