CREATE TABLE coursework (
    coursework_id INT PRIMARY KEY NOT NULL,
    week_id INT NOT NULL,
    description VARCHAR(255) NOT NULL,
    FOREIGN KEY (week_id) REFERENCES weeks(week_id)
);

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
VALUES (18, 5, 'Week 5.5 : Update Existing Terraform');