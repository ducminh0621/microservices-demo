variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources in"
  default     = "ap-northeast-2"
}

variable "name" {
  type        = string
  description = "Name given to the new EKS cluster"
  default     = "online-boutique"
}

variable "namespace" {
  type        = string
  description = "Kubernetes Namespace in which the Online Boutique resources are to be deployed"
  default     = "default"
}

variable "filepath_manifest" {
  type        = string
  description = "Path to Online Boutique's Kubernetes resources, written using Kustomize"
  default     = "../kustomize/"
}

variable "elasticache" {
  type        = bool
  description = "If true, Online Boutique's in-cluster Redis cache will be replaced with an Amazon ElastiCache Redis cache"
}

variable "node_instance_type" {
  type        = string
  description = "EC2 instance type for EKS managed node group"
  default     = "t3.medium"
}

variable "node_min_size" {
  type        = number
  description = "Minimum number of nodes in the EKS managed node group"
  default     = 2
}

variable "node_max_size" {
  type        = number
  description = "Maximum number of nodes in the EKS managed node group"
  default     = 4
}
