with
  elf_lists as (
    select
      string_to_array(elf1, '-') as elf1,
      string_to_array(elf2, '-') as elf2
    from
      d04
  ),
  elf_numbers as (
    select
      elf1[1]::int as elf1_min,
      elf1[2]::int as elf1_max,
      elf2[1]::int as elf2_min,
      elf2[2]::int as elf2_max
    from
      elf_lists
  )
select
  sum(
    case
      when elf1_min <= elf2_min
      and elf2_max <= elf1_max then 1
      when elf2_min <= elf1_min
      and elf1_max <= elf2_max then 1
      else 0
    end
  ) as part_1,
  sum(
    case
      when elf2_min <= elf1_min
      and elf1_min <= elf2_max
      or elf2_min <= elf1_max
      and elf1_max <= elf2_max then 1
      when elf1_min <= elf2_min
      and elf2_min <= elf1_max
      or elf1_min <= elf2_max
      and elf2_max <= elf1_max then 1
      else 0
    end
  ) as part_2
from
  elf_numbers;