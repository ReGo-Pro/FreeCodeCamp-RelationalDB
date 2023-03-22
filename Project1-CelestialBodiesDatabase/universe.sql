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