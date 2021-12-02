SELECT name FROM animals WHERE name like '%mon%';
SELECT name FROM animals WHERE date_of_birth < '2019-01-01' AND date_of_birth > '2015-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT name FROM animals WHERE neutered = true;
SELECT name FROM animals WHERE NOT name = 'Gabumon';
SELECT name FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- How many animals are there?
SELECT COUNT(name) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts <= 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?

SELECT name, escape_attempts FROM animals
WHERE escape_attempts = (SELECT MAX(escape_attempts) FROM animals);

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals
  WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
  GROUP BY species;

-- What animals belong to Melody Pond?
SELECT name FROM animals
  JOIN owners ON animals.owner_id = owners.id
  WHERE owners.name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT name FROM animals
  JOIN species ON animals.species_id = species.id
  WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT animals.name, owners.full_name
  FROM owners
  LEFT JOIN animals ON owners.id = animals.owner_id;

-- How many animals are there per species?
SELECT species.name, COUNT(species.name)
  FROM animals
  JOIN species ON animals.species_id = species.id
  GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name, species.name, owners.full_name
  FROM animals
  JOIN owners ON animals.owner_id = owners.id
  JOIN species ON animals.species_id = species.id
  WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name, owners.full_name, animals.escape_attempts
  FROM animals
  JOIN owners ON animals.owner_id = owners.id
  WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts <= 0;

-- Who owns the most animals?
SELECT owners.full_name, COUNT(animals.name)
  FROM animals
  JOIN owners ON animals.owner_id = owners.id
  GROUP BY owners.full_name;