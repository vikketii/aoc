with
  meals_calories as (
    with
      meals as (
        select
          value as calories,
          (
            sum(
              case
                when value is null then 1
                else 0
              end
            ) over (
              order by
                id
            )
          ) + 1 as meal_id
        from
          d01.inputs
      )
    select
      meal_id,
      sum(calories) as meal_calories
    from
      meals
    group by
      meal_id
    order by
      meal_calories desc
    limit
      3
  )
select
  meal_calories as part_1,
  (
    select
      sum(meal_calories)
    from
      meals_calories
  ) as part_2
from
  meals_calories
limit
  1;