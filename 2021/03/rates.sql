drop table if exists aoc_03;

create table aoc_03
    (
        id serial,
        report_data bit(12)
    );

-- insert into
--     aoc_03 (report_data)
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

\copy aoc_03 (report_data) from 'input'

-- PART 1
with binaries as (
    select
        set_bit(b'000000000000', 0, case when (sum(get_bit(report_data, 0)) > count(report_data)/2) then 1 else 0 end) as b0,
        set_bit(b'000000000000', 1, case when (sum(get_bit(report_data, 1)) > count(report_data)/2) then 1 else 0 end) as b1,
        set_bit(b'000000000000', 2, case when (sum(get_bit(report_data, 2)) > count(report_data)/2) then 1 else 0 end) as b2,
        set_bit(b'000000000000', 3, case when (sum(get_bit(report_data, 3)) > count(report_data)/2) then 1 else 0 end) as b3,
        set_bit(b'000000000000', 4, case when (sum(get_bit(report_data, 4)) > count(report_data)/2) then 1 else 0 end) as b4,
        set_bit(b'000000000000', 5, case when (sum(get_bit(report_data, 5)) > count(report_data)/2) then 1 else 0 end) as b5,
        set_bit(b'000000000000', 6, case when (sum(get_bit(report_data, 6)) > count(report_data)/2) then 1 else 0 end) as b6,
        set_bit(b'000000000000', 7, case when (sum(get_bit(report_data, 7)) > count(report_data)/2) then 1 else 0 end) as b7,
        set_bit(b'000000000000', 8, case when (sum(get_bit(report_data, 8)) > count(report_data)/2) then 1 else 0 end) as b8,
        set_bit(b'000000000000', 9, case when (sum(get_bit(report_data, 9)) > count(report_data)/2) then 1 else 0 end) as b9,
        set_bit(b'000000000000', 10, case when (sum(get_bit(report_data, 10)) > count(report_data)/2) then 1 else 0 end) as b10,
        set_bit(b'000000000000', 11, case when (sum(get_bit(report_data, 11)) > count(report_data)/2) then 1 else 0 end) as b11
    from aoc_03
)
select
    (b0 | b1 | b2 | b3 | b4 | b5 | b6 | b7 | b8 | b9 | b10 | b11 )::int *
    (~(b0 | b1 | b2 | b3 | b4 | b5 | b6 | b7 | b8 | b9 | b10 | b11 ))::int as part1
from binaries;


-- PART 2
with result1 as (
    with recursive rb_max
        (data_left, x, i)
    as (

        select 
            report_data,
            case
                when ((sum(get_bit(report_data, 0)) over ()) > (count(report_data) over()) / 2) then 1
                else 0
            end,
            0
        from aoc_03

        union all

        select
            rb_max.data_left,
            case
                when ((sum(get_bit(rb_max.data_left, rb_max.i+1)) over ()) > (count(rb_max.data_left) over()) / 2) then 1
                else 0
            end,
            rb_max.i + 1
        from rb_max
        where get_bit(rb_max.data_left, rb_max.i) = rb_max.x
        and rb_max.i < 11
    )

    select
        *
    from rb_max
    where i = (select max(i) from rb_max)
    order by rb_max.data_left desc
    limit 1


), result2 as (
    with recursive rb_min
        (data_left, x, i)
    as (

        select 
            report_data,
            case
                when ((sum(get_bit(report_data, 0)) over ()) < (count(report_data) over()) / 2) then 1
                else 0
            end,
            0
        from aoc_03

        union all

        select
            rb_min.data_left,
            case
                when ((sum(get_bit(rb_min.data_left, rb_min.i+1)) over ()) < (count(rb_min.data_left) over()) / 2) then 1
                else 0
            end,
            rb_min.i + 1
        from rb_min
        where get_bit(rb_min.data_left, rb_min.i) = rb_min.x
        and rb_min.i < 11
    )

    select
        *
    from rb_min
    where i = (select max(i) from rb_min)
    order by rb_min.data_left desc
    limit 1
)

select
    result1.data_left::int * result2.data_left::int as part2
from result1, result2;