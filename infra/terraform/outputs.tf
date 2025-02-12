output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster for the OpenID Connect identity provider"
  value       = module.eks.cluster_oidc_issuer_url
}

output "aws_account_id" {
  description = "Account Id of your AWS account"
  sensitive = true
  value = data.aws_caller_identity.current.account_id
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  sensitive = true
  value = module.eks.cluster_certificate_authority_data
}

output "domain" {
  description = "The domain name to access your application from"
  value = var.domain
}

output "email" {
  description = "The email address to use in the creation of your SSL certificate"
  value = var.email
}