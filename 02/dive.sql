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


create or replace function step(
    internal integer,
    direction text,
    distance integer,
    aim integer
) returns integer as $$
    select
        case
            when direction = 'forward' then internal + (distance * aim)
            else internal
        end;
$$ language sql;


create or replace aggregate depth (text, integer, integer) (
    sfunc = step,
    stype = integer,
    initcond = 0
);

create or replace function addition (
    internal point,
    direction text,
    distance integer
) returns point as $$
    select
        case
            when direction = 'forward' then internal + Point(distance, 0)
            when direction = 'down' then internal + Point(0, distance)
            when direction = 'up' then internal - Point(0, distance)
        end;
$$ language sql;


create or replace aggregate my_sum (text, integer) (
    sfunc = addition,
    stype = point,
    initcond = '(0, 0)'
);


with result as (
with coords_result as (
    select
        id,
        direction,
        distance,
        my_sum(direction, distance) over(order by id) as coords
    from aoc_02
)
select
    coords,
    depth(direction, distance, coords[1]::int) over() as depth
from coords_result
order by id desc
limit 1
)
select
    coords[0] * coords[1] as part1,
    depth * coords[0] as part2
from result;
