-- get all data for: coursework_id 1
SELECT
    trainees.trainee_id,
    trainees.first_name,
    trainees.last_name,
    coursework.coursework_id,
    coursework.description,
    trainee_coursework.completed
FROM trainees
JOIN trainee_coursework
ON trainees.trainee_id = trainee_coursework.trainee_id
JOIN coursework
ON trainee_coursework.coursework_id = coursework.coursework_id
WHERE coursework.coursework_id = 1;
--  trainee_id | first_name | last_name  | coursework_id |           description            | completed
-- ------------+------------+------------+---------------+----------------------------------+-----------
--           1 | Navid      | Hejazi     |             1 | Week 1.1 - Deploy Frontend to S3 | f
--           2 | Jan        | Softa      |             1 | Week 1.1 - Deploy Frontend to S3 | f
--           3 | Maksim     | Lukianenko |             1 | Week 1.1 - Deploy Frontend to S3 | f
--           4 | Farzaneh   | Haghani    |             1 | Week 1.1 - Deploy Frontend to S3 | f
--           5 | Baz        | Murphy     |             1 | Week 1.1 - Deploy Frontend to S3 | f



-- get all data for: trainee_id 1
SELECT
    trainees.trainee_id,
    trainees.first_name,
    trainees.last_name,
    coursework.coursework_id,
    coursework.description,
    trainee_coursework.completed
FROM trainees
JOIN trainee_coursework
ON trainees.trainee_id = trainee_coursework.trainee_id
JOIN coursework
ON trainee_coursework.coursework_id = coursework.coursework_id
WHERE trainees.trainee_id = 1;
--  trainee_id | first_name | last_name | coursework_id |                          description                           | completed
-- ------------+------------+-----------+---------------+----------------------------------------------------------------+-----------
--           1 | Navid      | Hejazi    |             1 | Week 1.1 - Deploy Frontend to S3                               | f
--           1 | Navid      | Hejazi    |             2 | Week 1.2 : Deploy Backend to EC2                               | f
--           1 | Navid      | Hejazi    |             3 | Week 1.3 : Deploy Database to RDS                              | f
--           1 | Navid      | Hejazi    |             4 | Week 2.1 : Setup Github Actions for Frontend deployments to S3 | f
--           1 | Navid      | Hejazi    |             5 | Week 2.2 : Setup Github Actions for Backend deployments to EC2 | f
--           1 | Navid      | Hejazi    |             6 | Week 3.1 : Dockerize Frontend                                  | f
--           1 | Navid      | Hejazi    |             7 | Week 3.2 : Dockerize Backend                                   | f
--           1 | Navid      | Hejazi    |             8 | Week 3.3 : Dockerize Database                                  | f
--           1 | Navid      | Hejazi    |             9 | Week 3.4 : Deploy Docker Images to AWS                         | f
--           1 | Navid      | Hejazi    |            10 | Week 4.1 : Use Terraform to deploy Frontend to S3              | f
--           1 | Navid      | Hejazi    |            11 | Week 4.2 : Use Terraform to deploy Backend to EC2              | f
--           1 | Navid      | Hejazi    |            12 | Week 4.3 : Use Terraform to deploy Database to RDS             | f
--           1 | Navid      | Hejazi    |            13 | Week 4.4 : Use Terraform Modules and Remote State              | f
--           1 | Navid      | Hejazi    |            14 | Week 5.1 : Setup EC2 Load Balancers                            | f
--           1 | Navid      | Hejazi    |            15 | Week 5.2 : Set High Availability for RDS                       | f
--           1 | Navid      | Hejazi    |            16 | Week 5.3 : Enable Cloudwatch Alarms                            | f
--           1 | Navid      | Hejazi    |            17 | Week 5.4 : Use CloudWatch Metrics to Create Dashboards         | f
--           1 | Navid      | Hejazi    |            18 | Week 5.5 : Update Existing Terraform                           | f



-- get completed data for : coursework_id 1
SELECT
    trainee_coursework.trainee_id,
    trainee_coursework.coursework_id,
    trainee_coursework.completed
FROM trainee_coursework
WHERE trainee_coursework.coursework_id = 1;
--  trainee_id | coursework_id | completed
-- ------------+---------------+-----------
--           1 |             1 | f
--           2 |             1 | f
--           3 |             1 | f
--           4 |             1 | f
--           5 |             1 | f
