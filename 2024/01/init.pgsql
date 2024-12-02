DROP table if EXISTS d01;

CREATE TABLE d01 (
  id    SERIAL,
  value_left integer,
  value_right integer
);

-- Use \COPY rather than COPY so its client-side in psql
\COPY d01 (value_left, value_right) FROM '2024/01/input.txt' with delimiter ';';
