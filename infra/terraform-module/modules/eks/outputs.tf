output "cluster_id" {
  description = "The EKS cluster ID"
  value       = aws_eks_cluster.this.id
}

output "cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_certificate_authority_data" {
  description = "The certificate data for the EKS cluster"
  value       = aws_eks_cluster.this.certificate_authority[0].data
}