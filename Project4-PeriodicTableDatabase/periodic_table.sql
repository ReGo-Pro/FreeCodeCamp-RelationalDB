CREATE TABLE types (
	type_id SERIAL PRIMARY KEY,
	type VARCHAR(16) NOT NULL
);

insert into types (type) values ('metal'), ('nonmetal'), ('metalloid');

ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;
ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;
ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;

ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL;
ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL;
ALTER TABLE elements ALTER COLUMN name SET NOT NULL;
ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL;

ALTER TABLE elements ADD CONSTRAINT unique_element_name UNIQUE (name);
ALTER TABLE elements ADD CONSTRAINT unique_element_symbol UNIQUE (symbol);

ALTER TABLE properties ADD CONSTRAINT fk_properties_elements FOREIGN KEY (atomic_number) REFERENCES elements(atomic_number);

-- Add forign key constraint to properties table, update valus, drop unnecessary column
ALTER TABLE properties ADD type_id INT;
ALTER TABLE properties ADD CONSTRAINT fk_properties_types FOREIGN KEY (type_id) REFERENCES types(type_id);
UPDATE properties SET type_id = (SELECT type_id FROM types WHERE type = 'metal') WHERE type = 'metal';
UPDATE properties SET type_id = (SELECT type_id FROM types WHERE type = 'nonmetal') WHERE type = 'nonmetal';
UPDATE properties SET type_id = (SELECT type_id FROM types WHERE type = 'metalloid') WHERE type = 'metalloid';
ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL;
ALTER TABLE properties DROP COLUMN type;

UPDATE elements SET symbol = INITCAP(symbol);

-- Remove trailing zeros from atomic_mass column in properties table
ALTER TABLE properties ALTER COLUMN atomic_mass TYPE DECIMAL;
UPDATE properties SET atomic_mass = TRIM(TRAILING '0' FROM atomic_mass::text)::numeric;