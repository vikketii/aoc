with
  scores as (
    with
      scores as (
        with
          scores as (
            select
              ascii(elf) - 64 as elf_score,
              ascii(me) - 87 as my_score
            from
              d02
          )
        select
          elf_score,
          my_score,
          (
            select
              case
                when elf_score = my_score then 0
                when my_score - elf_score in (1, -2) then 1
                when my_score - elf_score in (-1, 2) then -1
              end
          ) as result_p1
        from
          scores
      )
    select
      elf_score,
      my_score,
      result_p1,
      (
        select
          case
            when result_p1 = 1 then 6
            when result_p1 = 0 then 3
            else 0
          end
      ) + my_score as final_score_p1,
      (
        select
          case
            when my_score = 1 then (
              select
                case
                  when elf_score = 1 then 3
                  when elf_score = 2 then 1
                  when elf_score = 3 then 2
                end
            )
            when my_score = 2 then 3 + elf_score
            when my_score = 3 then 6 + (
              select
                case
                  when elf_score = 1 then 2
                  when elf_score = 2 then 3
                  when elf_score = 3 then 1
                end
            )
          end
      ) as final_score_p2
    from
      scores
  )
select
  sum(final_score_p1) as part_1,
  sum(final_score_p2) as part_2
from
  scores;