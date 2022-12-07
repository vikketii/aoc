DROP table IF EXISTS d06;

CREATE TABLE d06 (
  id    SERIAL,
  inputs  text
);

\COPY d06 (inputs) FROM '2022/06/input.txt'
