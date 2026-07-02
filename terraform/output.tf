output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = aws_eks_cluster.my_cluster.name
}

output "cluster_endpoint" {
  description = "Endpoint of the EKS cluster"
  value       = aws_eks_cluster.my_cluster.endpoint
}

output "cluster_region" {
  description = "AWS region of the EKS cluster"
  value       = var.aws_region
}
