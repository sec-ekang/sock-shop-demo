variable "domain_name" {
  description = "Domain name for the hosted zone (apex domain)"
  type        = string
  default     = "csrnet.nz"
}

variable "record_name" {
  description = "DNS record name to be created (e.g., www)"
  type        = string
  default     = "www"
}

variable "record_type" {
  description = "Type of DNS record"
  type        = string
  default     = "A"
}

variable "ttl" {
  description = "Time-to-live for the record (in seconds)"
  type        = number
  default     = 300
}

variable "records" {
  description = "List of record values (e.g., ALB DNS name)"
  type        = list(string)
}