variable "aws_region" {
  description = "AWS Region"
  default     = "eu-north-1"
}

variable "project_name" {
  description = "Project name for tags"
  default     = "worldpress-terraform"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "my_ip" {
  description = "My IP address for SSH access"
  type        = string
  default     = "195.160.232.67/32"
}

variable "db_username" {
  description = "Database administrator username"
  type        = string
  default     = "admin"
  sensitive   = true
}

variable "db_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
}
