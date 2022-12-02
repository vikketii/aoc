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
                when mod(elf_score - my_score + 3, 3) = 2 then 6
                when mod(elf_score - my_score + 3, 3) = 0 then 3
                else 0
              end
          ) + my_score as final_score_p1
        from
          scores
      )
    select
      final_score_p1,
      (
        select
          case
            when my_score = 1 then mod(elf_score + 1, 3) + 1
            when my_score = 2 then 3 + elf_score
            when my_score = 3 then 6 + mod(elf_score, 3) + 1
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