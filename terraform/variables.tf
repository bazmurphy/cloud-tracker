# variable "postgres_user" {
#   description = "RDS Instance PostgreSQL User"
#   type        = string
#   sensitive   = true
# }

# variable "postgres_password" {
#   description = "RDS Instance PostgreSQL Password"
#   type        = string
#   sensitive   = true
# }

# variable "postgres_database_name" {
#   description = "RDS Instance PostgreSQL Database Name"
#   type        = string
#   sensitive   = true
# }

# variable "postgres_connection_string" {
#   description = "value"
#   type        = string
#   sensitive   = true
# }

# variable "postgres_ssl" {
#   description = "value"
#   type        = string
#   sensitive   = true
# }

variable "secret_aws_cloudwatch_user_access_key_id" {
  description = "value"
  type        = string
  # sensitive   = true
}

variable "secret_aws_cloudwatch_user_secret_access_key" {
  description = "value"
  type        = string
  # sensitive   = true
}
