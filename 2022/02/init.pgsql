DROP table IF EXISTS d02;

CREATE TABLE d02 (
  id    SERIAL,
  elf   text,
  me    text
);

\COPY d02 (elf, me) FROM '2022/02/input.txt' WITH delimiter E' '
