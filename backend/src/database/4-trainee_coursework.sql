CREATE TABLE trainee_coursework (
    trainee_id INT NOT NULL,
    coursework_id INT NOT NULL,
    in_progress BOOLEAN DEFAULT false NOT NULL,
    need_help BOOLEAN DEFAULT false NOT NULL,
    completed BOOLEAN DEFAULT false NOT NULL,
    PRIMARY KEY (trainee_id, coursework_id),
    FOREIGN KEY (trainee_id) REFERENCES trainees(trainee_id),
    FOREIGN KEY (coursework_id) REFERENCES coursework(coursework_id)
);

INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (1, 1);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (1, 2);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (1, 3);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (1, 4);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (1, 5);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (1, 6);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (1, 7);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (1, 8);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (1, 9);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (1, 10);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (1, 11);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (1, 12);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (1, 13);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (1, 14);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (1, 15);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (1, 16);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (1, 17);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (1, 18);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (2, 1);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (2, 2);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (2, 3);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (2, 4);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (2, 5);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (2, 6);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (2, 7);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (2, 8);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (2, 9);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (2, 10);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (2, 11);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (2, 12);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (2, 13);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (2, 14);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (2, 15);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (2, 16);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (2, 17);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (2, 18);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (3, 1);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (3, 2);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (3, 3);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (3, 4);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (3, 5);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (3, 6);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (3, 7);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (3, 8);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (3, 9);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (3, 10);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (3, 11);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (3, 12);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (3, 13);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (3, 14);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (3, 15);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (3, 16);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (3, 17);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (3, 18);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (4, 1);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (4, 2);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (4, 3);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (4, 4);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (4, 5);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (4, 6);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (4, 7);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (4, 8);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (4, 9);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (4, 10);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (4, 11);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (4, 12);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (4, 13);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (4, 14);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (4, 15);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (4, 16);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (4, 17);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (4, 18);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (5, 1);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (5, 2);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (5, 3);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (5, 4);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (5, 5);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (5, 6);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (5, 7);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (5, 8);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (5, 9);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (5, 10);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (5, 11);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (5, 12);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (5, 13);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (5, 14);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (5, 15);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (5, 16);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (5, 17);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (5, 18);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (6, 1);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (6, 2);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (6, 3);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (6, 4);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (6, 5);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (6, 6);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (6, 7);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (6, 8);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (6, 9);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (6, 10);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (6, 11);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (6, 12);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (6, 13);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (6, 14);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (6, 15);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (6, 16);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (6, 17);
INSERT INTO trainee_coursework (trainee_id, coursework_id)
VALUES (6, 18);