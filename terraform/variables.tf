variable "postgres_user" {
  description = "RDS Instance PostgreSQL User"
  type        = string
  sensitive   = true
}

variable "postgres_password" {
  description = "RDS Instance PostgreSQL Password"
  type        = string
  sensitive   = true
}

variable "postgres_database_name" {
  description = "RDS Instance PostgreSQL Database Name"
  type        = string
  sensitive   = true
}