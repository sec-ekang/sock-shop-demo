variable "source_vmx" {
  type        = string
  description = "Path to the source VM's .vmx file"
  default     = "/path/to/source/ubuntu.vmx"  # Update this to your actual path
}

variable "ssh_username" {
  type        = string
  description = "SSH username for the source VM"
  default     = "ubuntu"  # Update if necessary
}

variable "ssh_password" {
  type        = string
  description = "SSH password for the source VM"
  default     = "ubuntu_password"  # Update to the actual password
}