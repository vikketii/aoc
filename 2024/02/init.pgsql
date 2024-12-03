DROP table if EXISTS d02;

CREATE TABLE d02 (
  id    SERIAL,
  levels integer[]
);

\COPY d02 (levels) FROM '2024/02/input.txt' with delimiter E' ';
