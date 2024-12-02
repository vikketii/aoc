with
  ordered_left as (
    select
      value_left,
      row_number() over (
        order by
          value_left asc
      ) AS row_number_left
    from
      d01
  ),
  ordered_right as (
    select
      value_right,
      row_number() over (
        order by
          value_right asc
      ) AS row_number_right
    from
      d01
  )
select
  sum(abs(value_left - value_right)) as part_1
from
  ordered_left
  left join ordered_right on (
    ordered_left.row_number_left = ordered_right.row_number_right
  );

with
  appearances as (
    select
      d01.value_left,
      count(t.value_right) as appearance_amount
    from
      d01
      join d01 as t on d01.value_left = t.value_right
    group by
      d01.value_left
  )
select
  sum(value_left * appearance_amount) as part_2
from
  appearances;