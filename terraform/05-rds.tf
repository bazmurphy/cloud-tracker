# -----------------------------------------------

# Create a Security Group (Firewall) for the RDS Database
resource "aws_security_group" "cloud_tracker_security_group_rds_database" {
  name   = "cloud-tracker-security-group-rds-database"
  vpc_id = aws_vpc.cloud_tracker_vpc.id

  # Incoming to Allow PostgreSQL
  ingress {
    from_port   = 5432 
    to_port     = 5432
    protocol    = "tcp"
    # Allow anything in the VPC to access the RDS Instance
    # cidr_blocks = ["10.1.0.0/16"]
    # Only allow the EC2 Instance to access the RDS Instance
    security_groups = [aws_security_group.cloud_tracker_security_group_ec2_instance.id]
  }

  # Outgoing to Allow PostgreSQL
  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.1.0.0/16"]
  }

  tags = {
    Name = "cloud-tracker-security-group-rds-database"
  }
}

# -----------------------------------------------

# Create a DB Subnet Group (a collection of VPC subnets that you can associate with your RDS instance)
resource "aws_db_subnet_group" "cloud_tracker_db_subnet_group" {
  name        = "cloud-tracker-db-subnet-group"
  description = "Database Subnet Group for cloud-tracker RDS Database"

  subnet_ids = [
    aws_subnet.cloud_tracker_subnet_private_one.id,
    aws_subnet.cloud_tracker_subnet_private_two.id,
  ]
}

# -----------------------------------------------

# Reference an SQL file to seed the RDS Instance
# data "template_file" "initialise" {
#   template = file("initialise.sql")
# }

# -----------------------------------------------

# Create an RDS Database
resource "aws_db_instance" "cloud_tracker_rds_database" {
  # Trying to replicate the manual create database user interface:

  # [1] Database Creation Method
  # Standard Create

  # [2] Engine Options
  # Engine Version
  engine = "postgres"
  engine_version = "15.3"

  # [3] Templates
  # Free Tier

  # [4] Availability and Durability 
  # greyed out on Free Tier

  # [5] Settings
  # DB Instance Identifier
  identifier = "cloud-tracker-rds-database"

  # Master Username
  username = var.postgres_user

  # Master Password
  password = var.postgres_password

  # [6] Instance Configuration
  # DB Instance Class
  instance_class = "db.t3.micro"

  # [7] Storage
  # Storage Type
  storage_type = "gp2"

  # Allocated Storage
  allocated_storage = 10

  # [8] Connectivity
  # Compute resource
  # Don't connect to an EC2 compute resource (non-automatic)

  # Virtual Private Cloud
  # ???

  # DB Subnet Group
  # The DB subnet group defines which subnets and IP ranges the DB instance can use in the VPC that you selected.
  db_subnet_group_name = aws_db_subnet_group.cloud_tracker_db_subnet_group.name

  # Public Access
  publicly_accessible = false

  # VPC Security Group (Firewall)
  # Choose one or more VPC security groups to allow access to your database. 
  # Make sure that the security group rules allow the appropriate incoming traffic.
  # Choose existing / Create new

  # Existing VPC Security Groups
  vpc_security_group_ids = [aws_security_group.cloud_tracker_security_group_rds_database.id]

  # Availability Zone
  availability_zone = data.aws_availability_zones.available.names[0]
  
  # RDS Proxy
  # ???

  # Certificate Authority
  # ??? (default rds-ca-2019)

  # Additional Configuration
  # Database Port
  port = 5432

  # [9] Database Authentication
  # Password Authentication / Password and IAM Database Authentication / Password and Kerberos Authentication

  # [10] Monitoring
  # Turn on Performance Insights
  performance_insights_enabled = false
  
  # Additional Configuration
  # Enhanced Monitoring
  # monitoring_interval = 0

  # [11] Additional Configuration
  # Initial Database Name
  db_name = var.postgres_database_name

  # DB Parameter Group
  parameter_group_name = "default.postgres15"

  # Backup
  # Enable Automated Backups
  # On / Off (default On)

  # Backup Retention Period
  backup_retention_period = 0

  # Backup Window
  # Choose A Window / No Preference
  # backup_window = ???

  # Copy tags to snapshots
  # copy_tags_to_snapshot = false

  # Backup Replication
  # Enable replication in another AWS Region
  # ???

  # Encyption
  # Enable Encryption
  # ???

  # AWS KMS key
  # (default) aws/rds

  # Log Exports
  # PostgreSQL log
  # Upgrade log

  # Maintenance
  # Enable auto minor version upgrade
  auto_minor_version_upgrade = true

  # Maintenance Window
  # maintenance_window = ???

  # Deletion Protection
  deletion_protection = false
}

# -----------------------------------------------

# Locally populate the Database - but the Security Groups prevents this because I am connecting from outside the VPC...

# resource "null_resource" "seed_database" {
#   triggers = {
#     instance_id = aws_db_instance.cloud_tracker_rds_database.id
#   }

#   provisioner "local-exec" {
#     command = "psql -h ${aws_db_instance.cloud_tracker_rds_database.address} -U ${aws_db_instance.cloud_tracker_rds_database.username} -d ${aws_db_instance.cloud_tracker_rds_database.db_name} -f intialise.sql"
#   }

#   depends_on = [aws_db_instance.cloud_tracker_rds_database]
# }

# data "local_file" "seed_data" {
#   depends_on = [null_resource.seed_database]
#   filename = "intialise.sql"
# }

# -----------------------------------------------