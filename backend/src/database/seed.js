const { Client } = require("pg");

const pgclient = new Client({
  connectionString: process.env.DB_CONNECTION_STRING,
  ssl: process.env.DB_SSL === "true" ? { rejectUnauthorized: false } : false,
});

async function seed() {
  await pgclient.connect();

  const traineesTable = `
    CREATE TABLE trainees (
        trainee_id INT PRIMARY KEY,
        first_name VARCHAR(255) NOT NULL,
        last_name VARCHAR(255) NOT NULL
    );`;

  await pgclient.query(traineesTable);

  const weeksTable = `
    CREATE TABLE weeks (
        week_id INT PRIMARY KEY,
        week_number INT UNIQUE NOT NULL
    );`;

  await pgclient.query(weeksTable);

  const courseworkTable = `
    CREATE TABLE coursework (
        coursework_id INT PRIMARY KEY NOT NULL,
        week_id INT NOT NULL,
        description VARCHAR(255) NOT NULL,
        FOREIGN KEY (week_id) REFERENCES weeks(week_id)
    );`;

  await pgclient.query(courseworkTable);

  const traineeCourseworkTable = `
    CREATE TABLE trainee_coursework (
        trainee_id INT NOT NULL,
        coursework_id INT NOT NULL,
        in_progress BOOLEAN DEFAULT false NOT NULL,
        need_help BOOLEAN DEFAULT false NOT NULL,
        completed BOOLEAN DEFAULT false NOT NULL,
        PRIMARY KEY (trainee_id, coursework_id),
        FOREIGN KEY (trainee_id) REFERENCES trainees(trainee_id),
        FOREIGN KEY (coursework_id) REFERENCES coursework(coursework_id)
    );`;

  await pgclient.query(traineeCourseworkTable);

  const traineesInsert = `
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
    VALUES(6, 'Chidimma', 'Ofodum');`;

  await pgclient.query(traineesInsert);

  const weeksInsert = `
    INSERT INTO weeks (week_id, week_number)
    VALUES (1, 1);
    INSERT INTO weeks (week_id, week_number)
    VALUES (2, 2);
    INSERT INTO weeks (week_id, week_number)
    VALUES (3, 3);
    INSERT INTO weeks (week_id, week_number)
    VALUES (4, 4);
    INSERT INTO weeks (week_id, week_number)
    VALUES (5, 5);`;

  await pgclient.query(weeksInsert);

  const courseworkInsert = `
    INSERT INTO coursework (coursework_id, week_id, description)
    VALUES (1, 1, 'Week 1.1 : Deploy Frontend to S3');
    INSERT INTO coursework (coursework_id, week_id, description)
    VALUES (2, 1, 'Week 1.2 : Deploy Backend to EC2');
    INSERT INTO coursework (coursework_id, week_id, description)
    VALUES (3, 1, 'Week 1.3 : Deploy Database to RDS');
    INSERT INTO coursework (coursework_id, week_id, description)
    VALUES (4, 2, 'Week 2.1 : Setup Github Actions for Frontend deployments to S3');
    INSERT INTO coursework (coursework_id, week_id, description)
    VALUES (5, 2, 'Week 2.2 : Setup Github Actions for Backend deployments to EC2');
    INSERT INTO coursework (coursework_id, week_id, description)
    VALUES (6, 2, 'Week 3.1 : Dockerize Frontend');
    INSERT INTO coursework (coursework_id, week_id, description)
    VALUES (7, 2, 'Week 3.2 : Dockerize Backend');
    INSERT INTO coursework (coursework_id, week_id, description)
    VALUES (8, 3, 'Week 3.3 : Dockerize Database');
    INSERT INTO coursework (coursework_id, week_id, description)
    VALUES (9, 3, 'Week 3.4 : Deploy Docker Images to AWS');
    INSERT INTO coursework (coursework_id, week_id, description)
    VALUES (10, 4, 'Week 4.1 : Use Terraform to deploy Frontend to S3');
    INSERT INTO coursework (coursework_id, week_id, description)
    VALUES (11, 4, 'Week 4.2 : Use Terraform to deploy Backend to EC2');
    INSERT INTO coursework (coursework_id, week_id, description)
    VALUES (12, 4, 'Week 4.3 : Use Terraform to deploy Database to RDS');
    INSERT INTO coursework (coursework_id, week_id, description)
    VALUES (13, 4, 'Week 4.4 : Use Terraform Modules and Remote State');
    INSERT INTO coursework (coursework_id, week_id, description)
    VALUES (14, 5, 'Week 5.1 : Setup EC2 Load Balancers');
    INSERT INTO coursework (coursework_id, week_id, description)
    VALUES (15, 5, 'Week 5.2 : Set High Availability for RDS');
    INSERT INTO coursework (coursework_id, week_id, description)
    VALUES (16, 5, 'Week 5.3 : Enable Cloudwatch Alarms');
    INSERT INTO coursework (coursework_id, week_id, description)
    VALUES (17, 5, 'Week 5.4 : Use CloudWatch Metrics to Create Dashboards');
    INSERT INTO coursework (coursework_id, week_id, description)
    VALUES (18, 5, 'Week 5.5 : Update Existing Terraform');`;

  await pgclient.query(courseworkInsert);

  const traineeCourseworkInsert = `
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
    VALUES (6, 18);`;

  await pgclient.query(traineeCourseworkInsert);

  const testQuery = await pgclient.query("SELECT * FROM trainees");
  console.log(testQuery.rows);

  await pgclient.end();
}

seed();
