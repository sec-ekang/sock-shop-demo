variable "subnet_group_name" {
  description = "Name for the DB subnet group"
  type        = string
}

variable "subnet_ids" {
  description = "List of private subnet IDs for RDS"
  type        = list(string)
}

variable "db_identifier" {
  description = "Identifier for the RDS instance"
  type        = string
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Allocated storage in GiB"
  type        = number
  default     = 20
}

variable "security_group_id" {
  description = "Security Group ID for RDS"
  type        = string
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = true
}

variable "monitoring_interval" {
  description = "Enhanced monitoring interval in seconds"
  type        = number
  default     = 60
}

variable "username" {
  description = "Database username"
  type        = string
}

variable "password" {
  description = "Database password"
  type        = string
  sensitive   = true
}