with
  item_lists as (
    select
      regexp_split_to_array(substr(inputs, 0, (char_length(inputs) / 2) + 1), '') as first_half,
      regexp_split_to_array(substr(inputs, (char_length(inputs) / 2) + 1, char_length(inputs)), '') as second_half
    from
      d03
  ),
  letters as (
    select
      (
        select
          unnest(first_half)
        intersect
        select
          unnest(second_half)
      ) as common_letter
    from
      item_lists
  )
select
  sum(
    case
      when ascii(common_letter) > 96 then ascii(common_letter) - 96
      else ascii(common_letter) - 38
    end
  ) as part_1
from
  letters;

with
  arrays as (
    select
      (
        sum(
          case
            when mod(id, 3) = 1 then 1
            else 0
          end
        ) over (
          order by
            id
        )
      ) as group_id,
      regexp_split_to_array(inputs, '') as letter_array
    from
      d03
  ),
  groups as (
    select
      group_id,
      letter_array as elf1,
      lag(letter_array, 1) over (
        partition by
          group_id
      ) as elf2,
      lag(letter_array, 2) over (
        partition by
          group_id
      ) as elf3
    from
      arrays
  ),
  letters as (
    select
      (
        select
          unnest(elf1)
        intersect
        select
          unnest(elf2)
        intersect
        select
          unnest(elf3)
      ) as common_letter
    from
      groups
    where
      elf3 is not null
  )
select
  sum(
    case
      when ascii(common_letter) > 96 then ascii(common_letter) - 96
      else ascii(common_letter) - 38
    end
  ) as part_2
from
  letters;