/* Populate database with sample data. */

INSERT INTO animals (name) VALUES ('Luna');
INSERT INTO animals (name) VALUES ('Daisy');
INSERT INTO animals (name) VALUES ('Charlie');
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Agumon', '2020-02-03', 10.23, true, 0),
( 'Gabumon', '2018-11-15', 8.00, TRUE, 2),
('Pikachu', '2021-01-07', 15.04, FALSE, 1),
('Devimon', '2017-05-12', 11.00, TRUE, 5);
('Charmander', '2020-02-08', -11.00, FALSE, 0),
('Plantmon', '2021-11-15', -5.70, TRUE, 2),
('Squirtle', '1993-04-02', -12.13, FALSE, 3),
('Angemon', '2005-06-12', -45.00, TRUE, 1),
('Boarmon', '2005-06-07', 20.40, TRUE, 7),
('Blossom', '1998-10-13', 17.00, TRUE,3),
('Ditto', '2022-05-14', 22.00, TRUE, 4);

INSERT INTO owners (full_name, age)
 VALUES ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

INSERT INTO species (name)
 VALUES ('Pokemon'),
  ('Digimon');

UPDATE animals     
 SET species_id = CASE
   WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
   ELSE (SELECT id FROM species WHERE name = 'Pokemon')
END;

UPDATE animals
SET owner_id = CASE
    WHEN name = 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
    WHEN name = 'Gabumon' OR name = 'Pikachu' THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
    WHEN name = 'Devimon' OR name = 'Plantmon' THEN (SELECT id FROM owners WHERE full_name = 'Bob')
    WHEN name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom' THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
    WHEN name = 'Angemon' OR name = 'Boarmon' THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
END;

INSERT INTO vets (name,age,date_of_graduation) VALUES 
('William Tatcher',45,'2000,04,23'),
('Maisy Smith',26,'2019,01,17'),
('Stephanie Mendez',64,'1981,05,04'),
('Jack Harkness',38,'2008,06,08');

INSERT INTO specializations (vets_id,species_id) VALUES
((SELECT id FROM vets WHERE name ='William Tatcher'),(SELECT id FROM species WHERE name='Pokemon')),
((SELECT id FROM vets WHERE name ='Stephanie Mendez'),(SELECT id FROM species WHERE name='Pokemon')),
((SELECT id FROM vets WHERE name ='Stephanie Mendez'),(SELECT id FROM species WHERE name='Digimon')),
((SELECT id FROM vets WHERE name ='Jack Harkness'),(SELECT id FROM species WHERE name='Digimon'));

INSERT INTO visits (animals_id,vets_id,visit_date) VALUES 
(
  (SELECT id from animals WHERE name = 'Agumon'),
  (SELECT id from vets WHERE name = 'William Tatcher'),
  ('2020,05,24')
),
(
  (SELECT id from animals WHERE name = 'Agumon'),
  (SELECT id from vets WHERE name = 'Stephanie Mendez'),
  ('2020,07,22')
),
(
  (SELECT id from animals WHERE name = 'Gabumon'),
  (SELECT id from vets WHERE name = 'Jack Harkness'),
  ('2021,02,02')
),
(
  (SELECT id from animals WHERE name = 'Pikachu'),
  (SELECT id from vets WHERE name = 'Maisy Smith'),
  ('2020,01,05')
),
(
  (SELECT id from animals WHERE name = 'Pikachu'),
  (SELECT id from vets WHERE name = 'Maisy Smith'),
  ('2020,03,08')
),
(
  (SELECT id from animals WHERE name = 'Pikachu'),
  (SELECT id from vets WHERE name = 'Maisy Smith'),
  ('2020,05,14')
),
(
  (SELECT id from animals WHERE name = 'Devimon'),
  (SELECT id from vets WHERE name = 'Stephanie Mendez'),
  ('2021,05,04')
),
(
  (SELECT id from animals WHERE name = 'Charmander'),
  (SELECT id from vets WHERE name = 'Jack Harkness'),
  ('2021,02,24')
),
(
  (SELECT id from animals WHERE name = 'Plantmon'),
  (SELECT id from vets WHERE name = 'Maisy Smith'),
  ('2019,12,21')
),
(
  (SELECT id from animals WHERE name = 'Plantmon'),
  (SELECT id from vets WHERE name = 'William Tatcher'),
  ('2020,08,10')
),
(
  (SELECT id from animals WHERE name = 'Plantmon'),
  (SELECT id from vets WHERE name = 'Maisy Smith'),
  ('2021,04,07')
),
(
  (SELECT id from animals WHERE name = 'Squirtle'),
  (SELECT id from vets WHERE name = 'Stephanie Mendez'),
  ('2019,09,29')
),
(
  (SELECT id from animals WHERE name = 'Angemon'),
  (SELECT id from vets WHERE name = 'Jack Harkness'),
  ('2020,10,03')
),
(
  (SELECT id from animals WHERE name = 'Angemon'),
  (SELECT id from vets WHERE name = 'Jack Harkness'),
  ('2020,11,04')
),
(
  (SELECT id from animals WHERE name = 'Boarmon'),
  (SELECT id from vets WHERE name = 'Maisy Smith'),
  ('2019,01,24')
),
(
  (SELECT id from animals WHERE name = 'Boarmon'),
  (SELECT id from vets WHERE name = 'Maisy Smith'),
  ('2019,05,15')
),
(
  (SELECT id from animals WHERE name = 'Boarmon'),
  (SELECT id from vets WHERE name = 'Maisy Smith'),
  ('2020,02,27')
),
(
  (SELECT id from animals WHERE name = 'Boarmon'),
  (SELECT id from vets WHERE name = 'Maisy Smith'),
  ('2020,08,03')
),
(
  (SELECT id from animals WHERE name = 'Blossom'),
  (SELECT id from vets WHERE name = 'Stephanie Mendez'),
  ('2020,05,24')
),
(
  (SELECT id from animals WHERE name = 'Blossom'),
  (SELECT id from vets WHERE name = 'William Tatcher'),
  ('2021,01,11')
);

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';