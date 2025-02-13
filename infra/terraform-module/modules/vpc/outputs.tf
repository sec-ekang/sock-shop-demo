output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "public_subnets_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_subnets_ids" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}

output "jenkins_sg_id" {
  description = "Jenkins Security Group ID"
  value       = aws_security_group.jenkins_sg.id
}

output "rds_sg_id" {
  description = "RDS Security Group ID"
  value       = aws_security_group.rds_sg.id
}

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = aws_nat_gateway.this.id
}