INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', 'February 3, 2020', 0, true, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', 'November 15, 2018', 2, true, 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', 'January 7, 2021', 1, false, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', 'May 12, 2017', 5, true, 11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', 'February 8, 2020', 0, false, -11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', 'November 15, 2022', 2, true, -5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', 'April 2, 1993', 3, false, -12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', 'June 12, 2005', 1, true, -45);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', 'June 7, 2005', 7, true, 20.4);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', 'October 13, 1998', 3, true, 17);

BEGIN;
  UPDATE animals
    SET species = 'unspecified'
ROLLBACK;

BEGIN;
  UPDATE animals
    SET species = 'Digimon' WHERE name like '%mon';
  UPDATE animals
    SET species = 'Pokemon' WHERE species is null;
COMMIT;

BEGIN;
  DELETE FROM animals;
ROLLBACK;


--TRANSACTIONS

-- Delete all animals born after Jan 1st, 2022.
BEGIN;
  DELETE FROM animals WHERE date_of_birth > '2022-01-01';

-- Create a savepoint for the transaction.
SAVEPOINT mydata;

-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals
  SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO mydata;

-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals
  SET weight_kg = weight_kg * -1;
  WHERE weight_kg < 0;

-- Commit transaction
COMMIT;

INSERT INTO species (name) VALUES ('Pokemon', 'Digimon');

INSERT INTO owners (name, age) VALUES ('Sam Smith', 34), ('Jenniger Orwell', 19), ('Bob', 45), ('Melody Pond', 77), ('Dean Winchester', 14), ('Jodie Whittaker', 38);

-- If the name ends in "mon" it will be Digimon
UPDATE animals
  SET species_id = 2
  WHERE name LIKE '%mon%';

-- All other animals are Pokemon
UPDATE animals
  SET species_id = species.id
  FROM species
  WHERE animals.name NOT LIKE '%mon%';

-- Sam Smith owns Agumon.
UPDATE animals
  SET owner_id = 7
  WHERE name = 'Agumon';

-- Jennifer Orwell owns Gabumon and Pikachu.
UPDATE animals
  SET owner_id = 8
  WHERE name = 'Gabumon' OR name = 'Pikachu';

-- Bob owns Devimon and Plantmon.
UPDATE animals
  SET owner_id = 9
  WHERE name = 'Devimon' OR name = 'Plantmon';

-- Melody Pond owns Charmander, Squirtle, and Blossom.
UPDATE animals
  SET owner_id = 10
  WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';

-- Dean Winchester owns Angemon and Boarmon.
UPDATE animals
  SET owner_id = 11
  WHERE name = 'Angemon' OR name = 'Boarmon';