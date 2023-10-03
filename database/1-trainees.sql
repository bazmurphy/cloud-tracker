CREATE TABLE trainees (
    trainee_id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL
);

INSERT INTO trainees (trainee_id, first_name, last_name)
VALUES (1, 'Navid', 'Hejazi');
INSERT INTO trainees (trainee_id, first_name, last_name)
VALUES (2, 'Jan', 'Softa');
INSERT INTO trainees (trainee_id, first_name, last_name)
VALUES (3, 'Maksim', 'Lukianenko');
INSERT INTO trainees (trainee_id, first_name, last_name)
VALUES (4, 'Farzaneh', 'Haghani');
INSERT INTO trainees (trainee_id, first_name, last_name)
VALUES (5, 'Baz', 'Murphy');
INSERT INTO trainees (trainee_id, first_name, last_name)
VALUES(6, 'Chidimma', 'Ofodum')