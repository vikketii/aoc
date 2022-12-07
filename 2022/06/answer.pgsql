with      signals as (
          select    d06.id,
                    regexp_split_to_table(inputs, '') as s
          from      d06
          ),
          groups as (
          select    id,
                    s,
                    lag(s) over () as s1,
                    lag(s, 2) over () as s2,
                    lag(s, 3) over () as s3
          from      signals
          ),
          results as (
          select    row_number() over () as id,
                    array[s, s1, s2, s3],
                    case
                              when array[s] <@ array[s1, s2, s3]
                              or        array[s1] <@ array[s, s2, s3]
                              or        array[s2] <@ array[s, s1, s3]
                              or        array[s3] <@ array[s, s1, s2] then 0
                                        else 1
                    end as uniq
          from      groups
          )
select    id as part_1
from      results
where     id > 3
and       uniq = 1
limit     1;

with      signals as (
          select    d06.id,
                    regexp_split_to_table(inputs, '') as s
          from      d06
          ),
          groups as (
          select    id,
                    s,
                    lag(s) over () as s1,
                    lag(s, 2) over () as s2,
                    lag(s, 3) over () as s3,
                    lag(s, 4) over () as s4,
                    lag(s, 5) over () as s5,
                    lag(s, 6) over () as s6,
                    lag(s, 7) over () as s7,
                    lag(s, 8) over () as s8,
                    lag(s, 9) over () as s9,
                    lag(s, 10) over () as s10,
                    lag(s, 11) over () as s11,
                    lag(s, 12) over () as s12,
                    lag(s, 13) over () as s13
          from      signals
          ),
          results as (
          select    row_number() over () as id,
                    case
                              when array[s] <@ array[s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13]
                              or        array[s1] <@ array[s, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13]
                              or        array[s2] <@ array[s1, s, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13]
                              or        array[s3] <@ array[s1, s2, s, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13]
                              or        array[s4] <@ array[s1, s2, s3, s, s5, s6, s7, s8, s9, s10, s11, s12, s13]
                              or        array[s5] <@ array[s1, s2, s3, s4, s, s6, s7, s8, s9, s10, s11, s12, s13]
                              or        array[s6] <@ array[s1, s2, s3, s4, s5, s, s7, s8, s9, s10, s11, s12, s13]
                              or        array[s7] <@ array[s1, s2, s3, s4, s5, s6, s, s8, s9, s10, s11, s12, s13]
                              or        array[s8] <@ array[s1, s2, s3, s4, s5, s6, s7, s, s9, s10, s11, s12, s13]
                              or        array[s9] <@ array[s1, s2, s3, s4, s5, s6, s7, s8, s, s10, s11, s12, s13]
                              or        array[s10] <@ array[s1, s2, s3, s4, s5, s6, s7, s8, s9, s, s11, s12, s13]
                              or        array[s11] <@ array[s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s, s12, s13]
                              or        array[s12] <@ array[s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s, s13]
                              or        array[s13] <@ array[s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s] then 0
                                        else 1
                    end as uniq
          from      groups
          )
select    id as part_2
from      results
where     id > 13
and       uniq = 1
limit     1;