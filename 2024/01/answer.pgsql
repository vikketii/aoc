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
  sum(abs(value_left - value_right)) as answer_1
from
  ordered_left
  left join ordered_right on (
    ordered_left.row_number_left = ordered_right.row_number_right
  )
limit
  10;