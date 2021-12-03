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

INSERT INTO vets (name, age, date_of_graduation)
VALUES
  ('William Tatcher', 45, '2000-4-23'),
  ('Maisy Smith', 26, '2019-1-17'),
  ('Stephanie Mendez', 64, '1981-5-4'),
  ('Jack Harkness', 38, '2008-6-8')
;

-- Who was the last animal seen by William Tatcher?
SELECT animals.name, vets.name, date_of_visit
  FROM visits
  JOIN animals ON animals.id = animals_id
  JOIN vets ON vets.id = vets_id
  WHERE vets.name = 'William Tatcher'
  ORDER BY date_of_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT vets.name, COUNT(animals_id)
  FROM visits
  JOIN animals ON animals.id = animals_id
  JOIN vets ON vets.id = vets_id
  WHERE vets.name = 'Stephanie Mendez'
  GROUP BY vets.name;

  -- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name
FROM vets
LEFT JOIN specializations ON vet_id = vets.id
LEFT JOIN species ON species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name
  FROM visits
  JOIN animals ON animals_id = animals.id
  JOIN vets ON vets_id = vets.id
  WHERE date_of_visit BETWEEN '2020-4-1' AND '2020-8-30' AND vets.name = 'Stephanie Mendez'
  ORDER BY animals.name;

-- What animal has the most visits to vets?
SELECT animals.name, COUNT(animals.name)
  FROM visits
  JOIN animals ON animals_id = animals.id
  JOIN vets ON vets_id = vets.id
  GROUP BY animals.name
  ORDER BY COUNT(animals.name) DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name, vets.name, date_of_visit
  FROM visits
  JOIN animals ON animals.id = animals_id
  JOIN vets ON vets.id = vets_id
  WHERE vets.name = 'Maisy Smith'
ORDER BY date_of_visit LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT
  animals.name,
  animals.date_of_birth,
  animals.escape_attempts,
  animals.neutered,
  animals.weight_kg,
  vets.name,
  vets.age,
  vets.date_of_graduation,
  visits.date_of_visit
  FROM visits
  JOIN animals ON animals_id = animals.id
  JOIN vets ON vets_id = vets.id
  ORDER BY date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT vets.name, COUNT(date_of_visit)
  FROM vets
  LEFT JOIN visits
  ON vets.id = visits.vets_id
  LEFT JOIN specializations
  ON vets.id = specializations.vet_id
  WHERE specializations.species_id IS NULL
  GROUP BY vets.name;


-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name, COUNT(species.name)
  FROM visits
  JOIN animals ON animals_id = animals.id
  JOIN vets ON vets_id = vets.id
  JOIN species ON animals.species_id = species.id
  WHERE vets.name = 'Maisy Smith'
  GROUP BY species.name
  ORDER BY COUNT(species.name) DESC LIMIT 1;