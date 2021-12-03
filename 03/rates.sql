drop table if exists aoc_03;

create table aoc_03
    (
        id serial,
        diagnostic bit(12)
    );

-- insert into
--     aoc_03 (diagnostic)
-- values
--     ('00100'),
--     ('11110'),
--     ('10110'),
--     ('10111'),
--     ('10101'),
--     ('01111'),
--     ('00111'),
--     ('11100'),
--     ('10000'),
--     ('11001'),
--     ('00010'),
--     ('01010');

\copy aoc_03 (diagnostic) from 'input'

with binaries as (
    select
        set_bit(b'000000000000', 0, case when (sum(get_bit(diagnostic, 0)) > count(diagnostic)/2) then 1 else 0 end) as b0,
        set_bit(b'000000000000', 1, case when (sum(get_bit(diagnostic, 1)) > count(diagnostic)/2) then 1 else 0 end) as b1,
        set_bit(b'000000000000', 2, case when (sum(get_bit(diagnostic, 2)) > count(diagnostic)/2) then 1 else 0 end) as b2,
        set_bit(b'000000000000', 3, case when (sum(get_bit(diagnostic, 3)) > count(diagnostic)/2) then 1 else 0 end) as b3,
        set_bit(b'000000000000', 4, case when (sum(get_bit(diagnostic, 4)) > count(diagnostic)/2) then 1 else 0 end) as b4,
        set_bit(b'000000000000', 5, case when (sum(get_bit(diagnostic, 5)) > count(diagnostic)/2) then 1 else 0 end) as b5,
        set_bit(b'000000000000', 6, case when (sum(get_bit(diagnostic, 6)) > count(diagnostic)/2) then 1 else 0 end) as b6,
        set_bit(b'000000000000', 7, case when (sum(get_bit(diagnostic, 7)) > count(diagnostic)/2) then 1 else 0 end) as b7,
        set_bit(b'000000000000', 8, case when (sum(get_bit(diagnostic, 8)) > count(diagnostic)/2) then 1 else 0 end) as b8,
        set_bit(b'000000000000', 9, case when (sum(get_bit(diagnostic, 9)) > count(diagnostic)/2) then 1 else 0 end) as b9,
        set_bit(b'000000000000', 10, case when (sum(get_bit(diagnostic, 10)) > count(diagnostic)/2) then 1 else 0 end) as b10,
        set_bit(b'000000000000', 11, case when (sum(get_bit(diagnostic, 11)) > count(diagnostic)/2) then 1 else 0 end) as b11
    from aoc_03
)
select
    (b0 | b1 | b2 | b3 | b4 | b5 | b6 | b7 | b8 | b9 | b10 | b11 )::int *
    (~(b0 | b1 | b2 | b3 | b4 | b5 | b6 | b7 | b8 | b9 | b10 | b11 ))::int
from binaries;
