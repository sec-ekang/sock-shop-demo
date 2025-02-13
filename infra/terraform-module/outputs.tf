output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "eks_cluster_id" {
  description = "The ID of the EKS cluster"
  value       = module.eks.cluster_id
}

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = module.alb.lb_dns_name
}

output "jenkins_instance_id" {
  description = "Jenkins instance ID"
  value       = module.jenkins.jenkins_instance_id
}

output "jenkins_public_ip" {
  description = "Public IP of the Jenkins instance"
  value       = module.jenkins.jenkins_public_ip
}

output "rds_instance_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = module.rds.rds_instance_endpoint
}

output "ecr_repository_spring_url" {
  description = "ECR repository URL for paperple-spring"
  value       = module.ecr_paperple_spring.repository_url
}

output "ecr_repository_ai_url" {
  description = "ECR repository URL for paperple-ai"
  value       = module.ecr_paperple_ai.repository_url
}

output "route53_record_fqdn" {
  description = "Fully qualified domain name for the Route53 record"
  value       = module.route53.record_fqdn
}