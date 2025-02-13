output "log_group_name" {
  description = "Name of the created CloudWatch log group"
  value       = aws_cloudwatch_log_group.this.name
}