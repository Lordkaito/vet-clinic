CREATE TABLE animals (
  id INTEGER,
  name VARCHAR(20),
  date_of_birth DATE,
  escape_attempts INTEGER,
  neutered BOOLEAN,
  weight_kg DECIMAL
);

ALTER TABLE animals
  ADD COLUMN species VARCHAR(20);