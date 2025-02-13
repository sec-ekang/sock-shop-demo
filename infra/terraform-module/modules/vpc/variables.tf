variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks (3 subnets: Jenkins, EKS, NAT)"
  type        = list(string)
}

variable "public_azs" {
  description = "Availability zones for public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks (2 subnets: RDS, EKS NodeGroup)"
  type        = list(string)
}

variable "private_azs" {
  description = "Availability zones for private subnets"
  type        = list(string)
}

variable "eks_nodes_cidr_blocks" {
  description = "CIDR blocks for EKS nodes allowed to access RDS"
  type        = list(string)
  default     = []
}