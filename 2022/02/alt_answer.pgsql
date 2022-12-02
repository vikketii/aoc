select
  sum(
    -- we could even remove this `format` step by simply treating the input as one line
    case format('%s%s', elf, me)
      when 'AX' then 4
      when 'AY' then 8
      when 'AZ' then 3
      when 'BX' then 1
      when 'BY' then 5
      when 'BZ' then 9
      when 'CX' then 7
      when 'CY' then 2
      when 'CZ' then 6
    end
  ) as part_1,
  sum(
    case format('%s%s', elf, me)
      when 'AX' then 3
      when 'AY' then 4
      when 'AZ' then 8
      when 'BX' then 1
      when 'BY' then 5
      when 'BZ' then 9
      when 'CX' then 2
      when 'CY' then 6
      when 'CZ' then 7
    end
  ) as part_2
from
  d02;