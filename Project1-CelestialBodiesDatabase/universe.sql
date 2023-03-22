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