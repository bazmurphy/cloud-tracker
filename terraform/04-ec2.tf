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
  owners      = ["amazon"] # Replace with the desired owner, e.g., "amazon" for AWS-provided AMIs
  most_recent = true

  filter {
    name   = "name"
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
  # user_data = file("ec2script.sh")

  user_data = templatefile(
    "ec2script.sh",
    {
      POSTGRES_USER        = local.postgres_user,
      POSTGRES_PASSWORD    = random_password.postgres_password.result,
      DB_CONNECTION_STRING = "postgresql://${local.postgres_user}:${random_password.postgres_password.result}@database/${local.postgres_database_name}",
      DB_SSL               = false
    }
  )

  tags = {
    Name = "cloud-tracker-ec2-instance"
  }

  # Define the IAM Instance Profile
  # iam_instance_profile = aws_iam_role.cloud_tracker_iam_role_ec2.id
}

# -----------------------------------------------
