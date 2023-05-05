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