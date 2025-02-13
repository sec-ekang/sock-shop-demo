variable "ami_id" {
  description = "AMI ID for the Jenkins instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for Jenkins"
  type        = string
  default     = "t3.medium"
}

variable "subnet_id" {
  description = "Subnet ID for Jenkins (e.g. Public Subnet 1)"
  type        = string
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "volume_size" {
  description = "Root volume size in GiB"
  type        = number
  default     = 20
}

variable "security_group_id" {
  description = "Security Group ID for the Jenkins instance"
  type        = string
}

variable "name" {
  description = "Name tag for the Jenkins instance"
  type        = string
}