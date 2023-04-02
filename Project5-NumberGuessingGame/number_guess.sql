CREATE DATABASE number_guess;

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(22) UNIQUE NOT NULL
);

ALTER TABLE users ADD games_played INT;
ALTER TABLE users ADD best_game INT;

ALTER TABLE users ALTER COLUMN games_played SET NOT NULL;
ALTER TABLE users ALTER COLUMN best_game SET NOT NULL;