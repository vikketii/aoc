DROP table IF EXISTS d05;

CREATE TABLE d05 (
  id    SERIAL,
  inputs TEXT
);

\COPY d05 (inputs) FROM '2022/05/input.txt';
