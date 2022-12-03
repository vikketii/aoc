DROP table IF EXISTS d03;

CREATE TABLE d03 (
  id    SERIAL,
  inputs   text
);

\COPY d03 (inputs) FROM '2022/03/input.txt' WITH delimiter E' '
