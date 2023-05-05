/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name = 'Luna';
SELECT * from animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = 'TRUE' AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = 'TRUE';
SELECT * FROM animals WHERE not name = 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 and 17.3;

BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species ='pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

BEGIN TRANSACTION;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT vet_clinic;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0; 
SELECT AVG(weight_kg) FROM animals;
SELECT 
 COUNT(*) FILTER (WHERE neutered = 't') AS neutered_count,
 COUNT(*) FILTER (WHERE neutered = 'f') AS not_neutered_count,
  AVG(CASE WHEN neutered = 't' THEN escape_attempts ELSE NULL END) AS neutered_avg_escape_attempts,
  AVG(CASE WHEN neutered = 'f' THEN escape_attempts ELSE NULL END) AS not_neutered_avg_escape_attempts
FROM animals;
SELECT species, MIN(weight_kg) AS min_weight_kg, MAX(weight_kg) AS max_weight_kg FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) AS avg_escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

SELECT animals.name AS animal_name, species.name AS species_name
  FROM animals
  JOIN owners ON animals.owner_id = owners.id
  JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name, species.name AS type
 FROM animals
 JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT owners.full_name AS owner_name, animals.name AS animal_name
 FROM owners
 LEFT JOIN animals ON owners.id = animals.owner_id
ORDER BY owners.full_name;

SELECT species.name AS species_name, COUNT(animals.id) AS num_animals
 FROM species
 LEFT JOIN animals ON species.id = animals.species_id
GROUP BY species.name;

SELECT animals.name AS animal_name, species.name AS species_name
 FROM animals
 JOIN species ON animals.species_id = species.id
 JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT name AS non_esc_animals
 FROM animals
 INNER JOIN owners ON animals.owner_id = owners.id
 WHERE animals.owner_id = (
      SELECT id
      FROM owners
      WHERE full_name = 'Dean Winchester'
)
AND animals.escape_attempts = 0;

SELECT owners.full_name, COUNT(animals.id) AS num_animals
 FROM owners
 LEFT JOIN animals ON owners.id = animals.owner_id
 GROUP BY owners.id
 ORDER BY num_animals DESC
LIMIT 1;