CREATE TABLE types (
	type_id SERIAL PRIMARY KEY,
	type VARCHAR(50) NOT NULL
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
