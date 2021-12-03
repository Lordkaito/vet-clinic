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

CREATE TABLE owners (
  id INTEGER PRIMARY KEY,
  full_name VARCHAR(40),
  age INTEGER
);

CREATE TABLE species (
  id INTEGER PRIMARY KEY,
  name VARCHAR(20)
);

-- The auto increment is alredy set on my table because of the use of SERIAL on CREATE TABLE at the beggining
ALTER TABLE animals
  ADD PRIMARY KEY (id);

ALTER TABLE animals
  DROP COLUMN species;

ALTER TABLE animals
  ADD COLUMN species_id INTEGER;

ALTER TABLE animals
  ADD FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals
  ADD COLUMN owners_id INTEGER;

ALTER TABLE animals
  ADD FOREIGN KEY (owner_id) REFERENCES owners(id);


CREATE TABLE vets (
  id SERIAL NOT NULL PRIMARY KEY,
  name VARCHAR(250),
  age INT,
  date_of_graduation date
);

CREATE TABLE specializations (
  species_id INT,
  vet_id INT,
  CONSTRAINT fk_species
    FOREIGN KEY(species_id)
      REFERENCES species(id),
  CONSTRAINT fk_vets
    FOREIGN KEY(vet_id)
      REFERENCES vets(id)
);

CREATE TABLE visits (
  animals_id INT,
  vets_id INT,
  date_of_visit date,
  CONSTRAINT fk_animals
    FOREIGN KEY(animals_id)
      REFERENCES animals(id),
  CONSTRAINT fk_vets
    FOREIGN KEY(vets_id)
      REFERENCES vets(id)
);