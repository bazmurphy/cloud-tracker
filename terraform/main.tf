# -----------------------------------------------

# Define the Provider and Region
provider "aws" {
  region = "eu-west-2"
}

# -----------------------------------------------

# Get the Availability Zones
data "aws_availability_zones" "available" {}

# -----------------------------------------------

# Create the VPC
resource "aws_vpc" "cloud_tracker_vpc" {
  cidr_block = "10.1.0.0/16"

  # DNS resolution through the Amazon DNS server is supported for the VPC
  enable_dns_support   = true
  # Instances launched in the VPC receive public DNS hostnames that correspond to their public IP addresses
  enable_dns_hostnames = true

  tags = {
    Name = "cloud-tracker-vpc"
  }
}

# (!) When a VPC is created: 
# a Default Route Table is automatically created
# a Default Security Group is automatically created

# -----------------------------------------------

# Configure the Default Route Table
resource "aws_default_route_table" "cloud_tracker_route_table_default" {
  default_route_table_id = aws_vpc.cloud_tracker_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cloud_tracker_internet_gateway.id
  }

  tags = {
    Name = "cloud-tracker-route-table-default"
  }
}

# -----------------------------------------------

# Create the Public Subnet One
resource "aws_subnet" "cloud_tracker_subnet_public_one" {
  vpc_id     = aws_vpc.cloud_tracker_vpc.id
  cidr_block = "10.1.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "cloud-tracker-subnet-public-one"
  }
}

# Create the Public Subnet Two
resource "aws_subnet" "cloud_tracker_subnet_public_two" {
  vpc_id     = aws_vpc.cloud_tracker_vpc.id
  cidr_block = "10.1.3.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "cloud-tracker-subnet-public-two"
  }
}

# -----------------------------------------------

# Associate the Public Subnet One with the Default Route Table
resource "aws_route_table_association" "cloud_tracker_route_table_association_public_one" {
  subnet_id      = aws_subnet.cloud_tracker_subnet_public_one.id
  route_table_id = aws_default_route_table.cloud_tracker_route_table_default.id
}

# Associate the Public Subnet Two with the Default Route Table
resource "aws_route_table_association" "cloud_tracker_route_table_association_public_two" {
  subnet_id      = aws_subnet.cloud_tracker_subnet_public_two.id
  route_table_id = aws_default_route_table.cloud_tracker_route_table_default.id
}

# -----------------------------------------------

# Create the Private Subnet One
resource "aws_subnet" "cloud_tracker_subnet_private_one" {
  vpc_id     = aws_vpc.cloud_tracker_vpc.id
  cidr_block = "10.1.2.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "cloud-tracker-subnet-private-one"
  }
}

# Create the Private Subnet Two
resource "aws_subnet" "cloud_tracker_subnet_private_two" {
  vpc_id     = aws_vpc.cloud_tracker_vpc.id
  cidr_block = "10.1.4.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "cloud-tracker-subnet-private-two"
  }
}

# -----------------------------------------------


# Create the Private Route Table
resource "aws_route_table" "cloud_tracker_route_table_private" {
  vpc_id = aws_vpc.cloud_tracker_vpc.id

  # If we don't define route { } here, it means traffic remains within the VPC

  # But how can it communicate across Subnets?

  tags = {
    Name = "cloud-tracker-route-table-private"
  }
}

# -----------------------------------------------

# Associate the Private Subnet One with the Private Route Table
resource "aws_route_table_association" "cloud_tracker_route_table_association_private_one" {
  subnet_id      = aws_subnet.cloud_tracker_subnet_private_one.id
  route_table_id = aws_route_table.cloud_tracker_route_table_private.id
}

# Associate the Private Subnet Two with the Private Route Table

resource "aws_route_table_association" "cloud_tracker_route_table_association_private_two" {
  subnet_id      = aws_subnet.cloud_tracker_subnet_private_two.id
  route_table_id = aws_route_table.cloud_tracker_route_table_private.id
}

# -----------------------------------------------

# Create the Internet Gateway
resource "aws_internet_gateway" "cloud_tracker_internet_gateway" {
  vpc_id = aws_vpc.cloud_tracker_vpc.id

  tags = {
    Name = "cloud-tracker-internet-gateway"
  }
}

# -----------------------------------------------

# # Configure the Default Network ACL on the VPC
# resource "aws_default_network_acl" "cloud_tracker_network_acl_default" {
#   default_network_acl_id = aws_vpc.cloud_tracker_vpc.default_network_acl_id

#   # Incoming to Allow Everything
#   ingress {
#     protocol   = -1
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 0
#     to_port    = 0
#   }

#   # Outgoing to Allow Everything
#   egress {
#     protocol   = -1
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 0
#     to_port    = 0
#   }

#   tags = {
#     Name = "cloud-tracker-network-acl-default"
#   }
# }

# -----------------------------------------------

# Configure the Automatically Created Default Security Group on the VPC
resource "aws_default_security_group" "cloud_tracker_security_group_vpc_default" {
  # name = "cloud-tracker-security-group-vpc-default"
  # Can't configure a value for "name": its value will be decided automatically based on the result of applying this configuration.
  
  vpc_id = aws_vpc.cloud_tracker_vpc.id

  # Incoming to Allow Everything
  # ingress {
  #   protocol  = -1
  #   self      = true
  #   from_port = 0
  #   to_port   = 0
  # }

  # Incoming to Allow SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Incoming to Allow HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outgoing to Allow Everything
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cloud-tracker-security-group-vpc-default"
  }
}

# -----------------------------------------------

# Create a Security Group (Firewall) for the EC2 Instance
resource "aws_security_group" "cloud_tracker_security_group_ec2_instance" {
  name   = "cloud-tracker-security-group-ec2-instance"
  vpc_id = aws_vpc.cloud_tracker_vpc.id

  # Incoming to Allow Everything
  # ingress {
  #   protocol  = -1
  #   self      = true
  #   from_port = 0
  #   to_port   = 0
  # }

  # Incoming to Allow SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  # Incoming to Allow HTTP
  ingress {
    from_port   = 80 
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  # Outgoing to Allow Everything
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cloud-tracker-security-group-ec2-instance"
  }
}

# -----------------------------------------------

# Dynamically Get the Amazon Linux 2023 AMI
data "aws_ami" "cloud_tracker_ec2_instance_ami" {
  owners = ["amazon"] # Replace with the desired owner, e.g., "amazon" for AWS-provided AMIs
  most_recent = true

  filter {
    name = "name"
    values = ["al2023-ami-2023*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

# -----------------------------------------------

## Create the EC2 Instance
resource "aws_instance" "cloud_tracker_ec2_instance" {
  # Trying to replicate the manual launch user interface:

  # [1] Use the Amazon Linux 2023 AMI
  # ami = "ami-04fb7beeed4da358b"
  ami = data.aws_ami.cloud_tracker_ec2_instance_ami.id

  # [2] Use the t2.micro Free Tier Instance Type
  instance_type = "t2.micro"

  # [3] Key pair for SSH access
  # key_name = "some-key-pair"

  # [4] Network Settings
  
  # VPC
  # Do we need to define that here?

  # Subnet
  subnet_id = aws_subnet.cloud_tracker_subnet_public_one.id

  # Auto-assing Public IP
  associate_public_ip_address = true

  # Firewall (Security Groups)
  vpc_security_group_ids = [aws_security_group.cloud_tracker_security_group_ec2_instance.id]

  # [5] Configure Storage
  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }
  
  # [6] Advanced Details

  # User Data
  user_data = file("ec2script.sh")

  tags = {
    Name = "cloud-tracker-ec2-instance"
  }

  # Define the IAM Instance Profile
  # iam_instance_profile = aws_iam_instance_profile.ec2_access_instance_profile.id
}

# -----------------------------------------------

# FOR LATER:

# Create an IAM User Group
# resource "aws_iam_group" "cloud_tracker_user_group" {
#   name = "cloud-tracker-user-group"
# }

# Create an IAM User
# resource "aws_iam_user" "cloud_tracker_user" {
#   name = "cloud-tracker-user"
# }

# Add the IAM User to the IAM User Group
# resource "aws_iam_user_group_membership" "cloud_tracker_user_group_membership" {
#   user = aws_iam_user.cloud_tracker_user.name
#   groups = [aws_iam_group.cloud_tracker_user_group.name]
# }

# Define a Policy Document
# resource "aws_iam_policy_document" "cloud_tracker_policy_document" {
#   version = "2012-10-17" # Terraform will choose a sensible option if not defined
#   statement { 
#     actions = [
#       "ec2:RunInstances",
#       "ec2:TerminateInstances",
#       "ec2:StopInstances",
#       "ec2:StartInstances",
#       "ec2:RebootInstances",
#       "ec2:DescribeInstances"
#     ]
#     effect    = "Allow" # this is optional, if not defined it defaults to Allow
#     resources = ["*"]
#   }
# }

# Create an IAM Policy from the Policy Document
# resource "aws_iam_policy" "cloud_tracker_policy_ec2" {
#   name = "cloud-tracker-policy-ec2"
#   policy = data.aws_iam_policy.cloud-tracker-policy-document.json
# }

# # Attach the IAM Policy to the IAM User Group
# resource "aws_iam_group_policy_attachment" "cloud-tracker-policy-attachment" {
#   policy_arn = aws_iam_policy.cloud_tracker_policy_ec2.arn
#   group = aws_iam_group.cloud_tracker_user_group.name
# }

# # Now use the IAM User for Terraform ???

# -----------------------------------------------

# Create the Private Subnet
# resource "aws_subnet" "cloud_tracker_subnet_private" {
#   vpc_id     = aws_vpc.cloud_tracker_vpc.id
#   cidr_block = "10.0.2.0/24"
  
#   tags = {
#     Name = "cloud-tracker-subnet-private"
#   }
# }

# Create the Private Route Table
# resource "aws_route_table" "cloud_tracker_route_table_private" {
#   vpc_id = aws_vpc.cloud_tracker_vpc.id
#
#   # If we don't define route { } here, it means traffic remains within the VPC
#
#   # But how can it communicate across Subnets?
#
#   tags = {
#     Name = "cloud-tracker-route-table-private"
#   }
# }

# Associate the Private Subnet with the Private Route Table
# resource "aws_route_table_association" "private" {
#   subnet_id      = aws_subnet.cloud_tracker_subnet_private.id
#   route_table_id = aws_route_table.cloud_tracker_route_table_private.id
# }

# -----------------------------------------------

# Create an IAM Role that allows EC2 access
# resource "aws_iam_role" "ec2_access_role" {
#   name = "EC2AccessRole"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Action = "sts:AssumeRole",
#         Effect = "Allow",
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       }
#     ]
#   })
# }

# Create an IAM Instance Profile and associate it with the IAM Role
# resource "aws_iam_instance_profile" "ec2_access_instance_profile" {
#   name = "EC2AccessInstanceProfile"
#   role = aws_iam_role.ec2_access_role.name
# }

# Attach the IAM Policy to the IAM Role
# resource "aws_iam_policy_attachment" "ec2_access_role_policy_attachment" {
#   name       = "EC2AccessRolePolicyAttachment"
#   roles      = [aws_iam_role.ec2_access_role.name]
#   policy_arn = aws_iam_policy.ec2_access_policy.arn
# }

# -----------------------------------------------

# SECURITY GROUPS

# Create a Security Group for the Frontend
# resource "aws_security_group" "cloud_tracker_security_group_frontend" {
#   name   = "cloud-tracker-security-group-frontend"
#   vpc_id = aws_vpc.cloud_tracker_vpc.id

#   ingress {
#     from_port   = 80 
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"] 
#   }
# }

# Create a Security Group for the Backend
# resource "aws_security_group" "cloud_tracker_security_group_backend" {
#   name   = "cloud-tracker-security-group-backend"
#   vpc_id = aws_vpc.cloud_tracker_vpc.id

#   ingress {
#     from_port       = 4000
#     to_port         = 4000 
#     protocol        = "tcp"
#     security_groups = [aws_security_group.cloud_tracker_security_group_frontend.id]
#   }
# }

# Create a Security Group for the Database
# resource "aws_security_group" "cloud_tracker_security_group_database" {
#   name   = "cloud-tracker-security-group-database"
#   vpc_id = aws_vpc.cloud_tracker_vpc.id

#   ingress {
#     from_port       = 5432
#     to_port         = 5432
#     protocol        = "tcp"
#     security_groups = [aws_security_group.cloud_tracker_security_group_backend.id]
#   }
# }

# -----------------------------------------------

# Create the Public Route Table (this is somewhat redundant when we use the Default Route Table)
# resource "aws_route_table" "cloud_tracker_route_table_public" {
#   vpc_id = aws_vpc.cloud_tracker_vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.cloud_tracker_internet_gateway.id
#   }

#   tags = {
#     Name = "cloud-tracker-route-table-public"
#   }
# }

# -----------------------------------------------

# Set the Public Route Table as the Main Route Table for the VPC
# resource "aws_main_route_table_association" "cloud_tracker_main_route_table_association" {
#   vpc_id = aws_vpc.cloud_tracker_vpc.id
#   route_table_id = aws_route_table.cloud_tracker_route_table_public.id
# }

# -----------------------------------------------

# Associate the Public Subnet with the Public Route Table
# resource "aws_route_table_association" "cloud_tracker_route_table_association" {
#   subnet_id      = aws_subnet.cloud_tracker_subnet_public.id
#   route_table_id = aws_route_table.cloud_tracker_route_table_public.id
# }

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

# Create Bucket
resource "aws_s3_bucket" "cloud_tracker_bucket" {
  # [1] General Configuration
  # Bucket Name
  bucket = "bazmurphy-cloud-tracker"

  # [7] Advanced Settings
  # Object Lock
  object_lock_enabled = false
}

# [2] Object Ownership
resource "aws_s3_bucket_ownership_controls" "cloud_tracker_bucket_ownership_controls" {
  bucket = aws_s3_bucket.cloud_tracker_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced" # BucketOwnerEnforced or BucketOwnerPreferred ???
  }
}

# [3] Block Public Access Settings For this Bucket
resource "aws_s3_bucket_public_access_block" "cloud_tracker_bucket_public_access_block" {
  bucket = aws_s3_bucket.cloud_tracker_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# [3] ACL - There is some conflict between ACL and the other Security Settings ???
# resource "aws_s3_bucket_acl" "cloud_tracker_bucket_acl" {
#   depends_on = [
#     aws_s3_bucket_ownership_controls.cloud_tracker_bucket_ownership_controls,
#     aws_s3_bucket_public_access_block.cloud_tracker_bucket_public_access_block,
#   ]
#   bucket = aws_s3_bucket.cloud_tracker_bucket.id
#   acl = "public-read"
# }

# [4] Bucket Versioning
resource "aws_s3_bucket_versioning" "cloud_tracker_bucket_versioning" {
  bucket = aws_s3_bucket.cloud_tracker_bucket.id

  versioning_configuration {
    status = "Disabled"
  }
}

# Bucket Properties > Static Website Hosting
resource "aws_s3_bucket_website_configuration" "cloud_tracker_bucket_website_configuration" {
  bucket = aws_s3_bucket.cloud_tracker_bucket.id

  index_document {
    suffix = "index.html"
  }
  # error_document {
    # key = "error.html"
  # }
}

# Define The S3 Policy Document
data "aws_iam_policy_document" "cloud_tracker_policy_document_s3" {
  statement {
    sid       = "PublicRead"
    effect    = "Allow"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = ["s3:*"]
    resources = ["${aws_s3_bucket.cloud_tracker_bucket.arn}/*"]
  }
}

# Attach The Policy To The S3 Bucket
resource "aws_s3_bucket_policy" "cloud_tracker_bucket_policy" {
  bucket = aws_s3_bucket.cloud_tracker_bucket.id
  policy = data.aws_iam_policy_document.cloud_tracker_policy_document_s3.json
}

# -----------------------------------------------

module "frontend_dist_folder" {
  source = "hashicorp/dir/template"

  # base_dir = "${path.module}/"
  base_dir = "../frontend/dist"
}

# Upload the contents of frontend/dist/ to the S3 Bucket
resource "aws_s3_object" "cloud_tracker_bucket_s3_object" {
  bucket = aws_s3_bucket.cloud_tracker_bucket.id
  
  for_each = module.frontend_dist_folder.files

  key = each.key
  content_type = each.value.content_type

  # The template_files module guarantees that only one of these two attributes will be set for each file,
  # depending on whether it is an in-memory template rendering result or a static file on disk.
  source  = each.value.source_path

  # (!) S3 assigns a Content Type of binary/octet-stream to uploaded files by default
  content = each.value.content

  # Unless the bucket has encryption enabled, the ETag of each object is an MD5 hash of that object.
  etag = each.value.digests.md5
}

# -----------------------------------------------