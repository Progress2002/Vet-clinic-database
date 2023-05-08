/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id BIGSERIAL NOT NULL,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN,
    weight_kg DECIMAL NOT NULL,
    PRIMARY KEY(id)
);

ALTER TABLE animals ADD COLUMN species VARCHAR(50);

CREATE TABLE owners (
 id BIGSERIAL PRIMARY KEY,
 full_name VARCHAR (150),
 age INT
);

CREATE TABLE species (
 id BIGSERIAL PRIMARY KEY,
 name VARCHAR(150)
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE  animals
ADD COLUMN species_id INTEGER REFERENCES species(id);

ALTER TABLE animals
ADD COLUMN owner_id INTEGER REFERENCES owners(id);

ALTER TABLE animals ADD CONSTRAINT FK_owners FOREIGN KEY(owner_id) REFERENCES owners(id);

CREATE TABLE  vets (
  id int GENERATED ALWAYS AS IDENTITY,
  name varchar(60),
  age int,
  date_of_graduation date,
  primary key(id)
);

CREATE TABLE specializations (
  id int primary key GENERATED ALWAYS AS IDENTITY,
  species_id int REFERENCES species(id),
  vets_id int REFERENCES vets(id) 
);

CREATE TABLE visits (
  id int primary key GENERATED ALWAYS AS IDENTITY,
  animals_id int REFERENCES animals(id),
  vets_id int REFERENCES vets(id),
  visit_date date
);
Footer
© 2023 GitHub, Inc.
Footer navigation
Terms
Privacy
Security
Status

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);