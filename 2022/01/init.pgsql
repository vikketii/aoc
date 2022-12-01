DROP SCHEMA IF EXISTS d01 CASCADE;
CREATE SCHEMA d01;

CREATE TABLE d01.inputs (
  id    SERIAL,
  value INTEGER
);

-- Use \COPY rather than COPY so its client-side in psql
\COPY d01.inputs (value) FROM '2022/01/input.txt' WITH (FORMAT 'text', NULL '');
