# -----------------------------------------------

# Get the Public IP of the created EC2 Instance
output "instance_public_ip" {
  description = "EC2 Instance Public IP"
  value = aws_instance.cloud_tracker_ec2_instance.public_ip
  sensitive   = true  
}

# Get the Public DNS of the created EC2 Instance
output "instance_public_dns" {
  description = "EC2 Instance Public DNS"
  value = aws_instance.cloud_tracker_ec2_instance.public_dns
  sensitive   = true
}

# URL
output "url" {
  description = "URL"
  value = "http://${aws_instance.cloud_tracker_ec2_instance.public_dns}"
  # sensitive   = true
}

# -----------------------------------------------

output "cloud_tracker_rds_database_address" {
  description = "RDS Instance Address"
  value       = aws_db_instance.cloud_tracker_rds_database.address
  sensitive   = true
}

output "cloud_tracker_rds_database_port" {
  description = "RDS Instance Port"
  value       = aws_db_instance.cloud_tracker_rds_database.port
  sensitive   = true
}

output "cloud_tracker_rds_database_username" {
  description = "RDS Instance Root Username"
  value       = aws_db_instance.cloud_tracker_rds_database.username
  sensitive   = true
}

output "cloud_tracker_rds_database_password" {
  description = "RDS Instance Root Password"
  value       = aws_db_instance.cloud_tracker_rds_database.password
  sensitive   = true
}

# -----------------------------------------------