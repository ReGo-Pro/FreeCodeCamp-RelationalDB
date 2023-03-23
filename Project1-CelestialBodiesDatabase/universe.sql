CREATE DATABASE universe;

-- Create galaxy table
CREATE TABLE galaxy (
	galaxy_id SERIAL PRIMARY KEY, 
	name VARCHAR(255) UNIQUE NOT null,
	age_million_years INT NOT NULL,
	diameter_thousand_light_years INT NOT NULL,
	solar_mass DECIMAL NOT NULL,
	has_active_galactic_nucleus BOOLEAN NOT NULL,
	is_ring_galaxy BOOLEAN NOT NULL,
	description TEXT NOT NULL
);

-- Fill galaxy table (ChatGPT is used for getting the information)
INSERT INTO galaxy (name, age_million_years, diameter_thousand_light_years, solar_mass, has_active_galactic_nucleus, is_ring_galaxy, description) VALUES
('Milky Way', 13000, 100, 1, FALSE, FALSE, 'The galaxy that contains our Solar System.'),
('Andromeda', 6000, 220, 1.2, TRUE, FALSE, 'The closest spiral galaxy to the Milky Way.'),
('Whirlpool', 300, 60, 0.3, FALSE, TRUE, 'A classic example of a grand-design spiral galaxy.'),
('Centaurus A', 12000, 12, 1.2, TRUE, FALSE, 'A peculiar galaxy that appears to be the result of a merger.'),
('NGC 4414', 2000, 80, 0.5, FALSE, FALSE, 'A beautiful barred spiral galaxy located in the constellation Coma Berenices.'),
('M82', 10, 5, 0.01, TRUE, FALSE, 'A starburst galaxy with an intense burst of star formation occurring in its nucleus.');

-- Create star table
CREATE TABLE star (
	star_id SERIAL PRIMARY KEY, 
	galaxy_id INT NOT NULL,
	name VARCHAR(255) UNIQUE NOT NULL,
	age_million_years INT NOT NULL,
	diameter_thousand_kilometers INT NOT NULL,
	solar_mass DECIMAL NOT NULL,
	is_visible BOOLEAN NOT NULL,
	is_exoplanet_host BOOLEAN NOT NULL,
	description TEXT NOT NULL,
	FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id)
);

-- Fill star table (ChatGPT is used for getting the information)
INSERT INTO star (galaxy_id, name, age_million_years, diameter_thousand_kilometers, solar_mass, is_visible, is_exoplanet_host, description)
VALUES
((SELECT galaxy_id FROM galaxy WHERE name = 'Milky Way'), 'Sun', 4602, 1392, 1.9885, true, true, 'The closest star to Earth.'),
((SELECT galaxy_id FROM galaxy WHERE name = 'Milky Way'), 'Sirius', 250, 18200, 2.063, true, true, 'The brightest star in the night sky.'),
((SELECT galaxy_id FROM galaxy WHERE name = 'Milky Way'), 'Alpha Centauri', 6000, 207, 2.447, true, true, 'The closest star system to Earth.'),
((SELECT galaxy_id FROM galaxy WHERE name = 'Andromeda'), 'Alpheratz', 70, 48, 1.8, true, false, 'The brightest star in the constellation Andromeda.'),
((SELECT galaxy_id FROM galaxy WHERE name = 'Andromeda'), 'Mirach', 200, 60, 3.26, true, false, 'A red giant star in the constellation Andromeda.'),
((SELECT galaxy_id FROM galaxy WHERE name = 'Whirlpool'), 'NGC 5195 X-1', 10, 1, 5, false, true, 'An ultra-luminous X-ray source in the galaxy NGC 5195.');

-- Create planet table
CREATE TABLE planet (
	planet_id SERIAL PRIMARY KEY, 
	star_id INT NOT NULL,
	name VARCHAR(255) UNIQUE NOT NULL,
	age_thousand_years INT NOT NULL,
	diameter_thousand_kilometers INT NOT NULL,
	solar_mass DECIMAL NOT NULL,
	can_support_life BOOLEAN NOT NULL,
	has_atmosphere BOOLEAN NOT NULL,
	description TEXT NOT NULL,
	FOREIGN KEY (star_id) REFERENCES star(star_id)
);

-- Fill planet table (ChatGPT is used for getting the information)
INSERT INTO planet (star_id, name, age_thousand_years, diameter_thousand_kilometers, solar_mass, can_support_life, has_atmosphere, description)
VALUES
((SELECT star_id FROM star WHERE name = 'Sun'), 'Mercury', 4500, 4880, 0.055, FALSE, FALSE, 'The smallest planet in the solar system.'),
((SELECT star_id FROM star WHERE name = 'Sun'), 'Venus', 4500, 12104, 0.815, FALSE, TRUE, 'The hottest planet in the solar system.'),
((SELECT star_id FROM star WHERE name = 'Sun'), 'Earth', 4500, 12756, 1, TRUE, TRUE, 'The only planet known to support life.'),
((SELECT star_id FROM star WHERE name = 'Sun'), 'Mars', 4500, 6792, 0.107, FALSE, FALSE, 'Often referred to as the "Red Planet".'),
((SELECT star_id FROM star WHERE name = 'Sun'), 'Jupiter', 4500, 142984, 317.8, FALSE, TRUE, 'The largest planet in the solar system.'),
((SELECT star_id FROM star WHERE name = 'Sun'), 'Saturn', 4500, 120536, 95.2, FALSE, TRUE, 'Known for its distinctive rings.'),
((SELECT star_id FROM star WHERE name = 'Sun'), 'Uranus', 4500, 51118, 14.5, FALSE, TRUE, 'The first planet discovered with a telescope.'),
((SELECT star_id FROM star WHERE name = 'Sun'), 'Neptune', 4500, 49528, 17.1, FALSE, TRUE, 'The farthest planet from the sun.'),
((SELECT star_id FROM star WHERE name = 'Sirius'), 'Sirius b', 5000, 12000, 0.005, false, true, 'A small rocky planet orbiting around the star Sirius.'),
((SELECT star_id FROM star WHERE name = 'Sirius'), 'Sirius c', 2000, 10000, 0.003, false, true, 'A colder and larger gas giant planet orbiting around the star Sirius.'),
((SELECT star_id FROM star WHERE name = 'Alpha Centauri'),'Alpha Centauri b', 8000, 15000, 0.01, true, true, 'A rocky planet with a thick atmosphere, potentially habitable, orbiting around the star Alpha Centauri.'),
((SELECT star_id FROM star WHERE name = 'Alpha Centauri'),'Alpha Centauri c', 3000, 20000, 0.02, false, true, 'A gas giant planet with multiple moons, orbiting around the star Alpha Centauri.');

-- Create planet moon
CREATE TABLE moon (
	moon_id SERIAL PRIMARY KEY, 
	planet_id INT NOT NULL,
	name VARCHAR(255) UNIQUE NOT NULL,
	age_thousand_years INT NOT NULL,
	diameter_thousand_kilometers INT NOT NULL,
	solar_mass DECIMAL NOT NULL,
	is_the_only_one BOOLEAN NOT NULL,
	has_atmosphere BOOLEAN NOT NULL,
	description TEXT NOT NULL,
	FOREIGN KEY (planet_id) REFERENCES planet(planet_id)
);