DROP table IF EXISTS d04;

CREATE TABLE d04 (
  id    SERIAL,
  elf1   text,
  elf2   text
);

\COPY d04 (elf1, elf2) FROM '2022/04/input.txt' WITH delimiter E','
