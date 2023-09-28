CREATE TABLE weeks (
    week_id INT PRIMARY KEY,
    week_number INT UNIQUE NOT NULL
);

INSERT INTO weeks (week_id, week_number)
VALUES (1, 1);
INSERT INTO weeks (week_id, week_number)
VALUES (2, 2);
INSERT INTO weeks (week_id, week_number)
VALUES (3, 3);
INSERT INTO weeks (week_id, week_number)
VALUES (4, 4);
INSERT INTO weeks (week_id, week_number)
VALUES (5, 5);