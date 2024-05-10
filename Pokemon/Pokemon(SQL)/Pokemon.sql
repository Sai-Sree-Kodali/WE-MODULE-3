CREATE DATABASE Pokemon;
USE Pokemon;



CREATE TABLE Type (
    type_id INTEGER PRIMARY KEY,
    type_name TEXT
);

CREATE TABLE Pokemon_Table (
    pokemon_id INTEGER PRIMARY KEY,
    pokemon_name TEXT,
    primary_type_id INTEGER,
    secondary_type_id INTEGER,
    FOREIGN KEY (primary_type_id) REFERENCES Type(type_id),
    FOREIGN KEY (secondary_type_id) REFERENCES Type(type_id)
);

INSERT INTO Type (type_id, type_name)
VALUES
    (1, 'Grass'),
    (2, 'Fire'),
    (3, 'Water'),
    (4, 'Normal'),
    (5, 'Flying');

INSERT INTO Pokemon_Table (pokemon_id, pokemon_name, primary_type_id, secondary_type_id)
VALUES
    (1, 'Bulbasaur', 1, NULL),
    (2, 'Charmander', 2, NULL),
    (3, 'Squirtle', 3, NULL),
    (4, 'Eevee', 4, NULL),
    (5, 'Pidgey', 4, 5);

CREATE TABLE Move (
    move_id INTEGER PRIMARY KEY,
    move_name TEXT,
    power INTEGER,
    type_id INTEGER REFERENCES Type(type_id)
);


INSERT INTO Move (move_id, move_name, power, type_id)
VALUES
    (1, 'Tackle', 35, 4),
    (2, 'Water Gun', 40, 3),
    (3, 'Ember', 40, 2),
    (4, 'Vine Whip', 40, 1),
    (5, 'Wing Attack', 65, 5),
    (6, 'Headbutt', 70, 4),
    (7, 'Return', 100, 4);

CREATE TABLE Pokemon_Move (
    pokemon_id INTEGER,
    move_id INTEGER,
    FOREIGN KEY (pokemon_id) REFERENCES Pokemon_Table(pokemon_id),
    FOREIGN KEY (move_id) REFERENCES Move(move_id)
);


INSERT INTO Pokemon_Move (pokemon_id, move_id)
VALUES
    (1, 1),
    (1, 4),
    (1, 7),
    (2, 1),
    (2, 3),
    (2, 7),
    (3, 1),
    (3, 2),
    (3, 7),
    (4, 1),
    (4, 6),
    (4, 7),
    (5, 1),
    (5, 5),
    (5, 7);

SELECT pt.pokemon_name
FROM Pokemon_Table pt
JOIN Pokemon_Move pm ON pt.pokemon_id = pm.pokemon_id
JOIN Move m ON pm.move_id = m.move_id
WHERE m.move_name = 'Return';

SELECT m.move_name
FROM Move m
JOIN Type t ON m.type_id = t.type_id
WHERE t.type_name IN ('Fire', 'Flying');
