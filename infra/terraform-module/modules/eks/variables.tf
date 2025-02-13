variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.21"
}

variable "cluster_subnet_ids" {
  description = "Subnets for the EKS cluster control plane"
  type        = list(string)
}

variable "node_subnet_ids" {
  description = "Subnets for the EKS node group"
  type        = list(string)
}

variable "cluster_role_arn" {
  description = "IAM role ARN for the EKS cluster"
  type        = string
}

variable "node_role_arn" {
  description = "IAM role ARN for the EKS node group"
  type        = string
}

variable "node_desired_capacity" {
  description = "Desired number of nodes"
  type        = number
  default     = 2
}

variable "node_max_capacity" {
  description = "Maximum number of nodes"
  type        = number
  default     = 4
}

variable "node_min_capacity" {
  description = "Minimum number of nodes"
  type        = number
  default     = 2
}

variable "node_instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "max_unavailable" {
  description = "Maximum number of nodes that can be unavailable during update"
  type        = number
  default     = 1
}