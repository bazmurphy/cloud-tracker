# -----------------------------------------------

# Create the VPC
resource "aws_vpc" "cloud_tracker_vpc" {
  cidr_block = "10.1.0.0/16"

  # DNS resolution through the Amazon DNS server is supported for the VPC
  enable_dns_support = true
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
  vpc_id            = aws_vpc.cloud_tracker_vpc.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  # Enable auto-assign public IPv4 address
  map_public_ip_on_launch = true

  tags = {
    Name = "cloud-tracker-subnet-public-one"
  }
}

# Create the Public Subnet Two
resource "aws_subnet" "cloud_tracker_subnet_public_two" {
  vpc_id            = aws_vpc.cloud_tracker_vpc.id
  cidr_block        = "10.1.3.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
  # Enable auto-assign public IPv4 address
  map_public_ip_on_launch = true

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
  vpc_id            = aws_vpc.cloud_tracker_vpc.id
  cidr_block        = "10.1.2.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "cloud-tracker-subnet-private-one"
  }
}

# Create the Private Subnet Two
resource "aws_subnet" "cloud_tracker_subnet_private_two" {
  vpc_id            = aws_vpc.cloud_tracker_vpc.id
  cidr_block        = "10.1.4.0/24"
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
resource "aws_default_network_acl" "cloud_tracker_network_acl_default" {
  default_network_acl_id = aws_vpc.cloud_tracker_vpc.default_network_acl_id

  # Incoming to Allow Everything
  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  # Outgoing to Allow Everything
  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  # If we don't list these it keeps trying to make changes
  subnet_ids = [
    aws_subnet.cloud_tracker_subnet_public_one.id,
    aws_subnet.cloud_tracker_subnet_public_two.id,
    aws_subnet.cloud_tracker_subnet_private_one.id,
    aws_subnet.cloud_tracker_subnet_private_two.id
  ]

  tags = {
    Name = "cloud-tracker-network-acl-default"
  }
}

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

# Create the Public Route Table (this is redundant when we use the Default Route Table)
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
