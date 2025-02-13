variable "log_group_name" {
  description = "Name of the CloudWatch log group"
  type        = string
}

variable "retention_in_days" {
  description = "Retention period for log events (in days)"
  type        = number
  default     = 7
}

variable "tags" {
  description = "Tags for the log group"
  type        = map(string)
  default     = {}
}