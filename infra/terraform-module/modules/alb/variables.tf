variable "lb_name" {
  description = "Name of the Load Balancer"
  type        = string
}

variable "lb_security_groups" {
  description = "Security groups for the Load Balancer"
  type        = list(string)
}

variable "subnet_ids" {
  description = "Subnets for the Load Balancer"
  type        = list(string)
}

variable "environment" {
  description = "Environment tag (e.g., dev, prod)"
  type        = string
}

variable "target_group_name" {
  description = "Name of the target group"
  type        = string
}

variable "target_port" {
  description = "Port for the target group"
  type        = number
}

variable "target_protocol" {
  description = "Protocol for the target group"
  type        = string
}

variable "health_check_path" {
  description = "Health check path for the target group"
  type        = string
}

variable "listener_port" {
  description = "Listener port for the ALB"
  type        = number
}

variable "listener_protocol" {
  description = "Listener protocol for the ALB"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the ALB is deployed"
  type        = string
}