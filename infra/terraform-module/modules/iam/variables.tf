variable "cluster_role_name" {
  description = "Name for the EKS cluster IAM role"
  type        = string
}

variable "cluster_policy_arns" {
  description = "List of managed policy ARNs for the EKS cluster role"
  type        = list(string)
}

variable "node_role_name" {
  description = "Name for the EKS node IAM role"
  type        = string
}

variable "node_policy_arns" {
  description = "List of managed policy ARNs for the EKS node role"
  type        = list(string)
}