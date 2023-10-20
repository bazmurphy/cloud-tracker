# -----------------------------------------------

# Define the Provider and Region
provider "aws" {
  region = "eu-west-2"
}

# -----------------------------------------------

# Get the Availability Zones
data "aws_availability_zones" "available" {}

# -----------------------------------------------