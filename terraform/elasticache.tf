# Create the ElastiCache (Redis) subnet group
resource "aws_elasticache_subnet_group" "redis" {
  name       = "${var.name}-redis-subnet-group"
  subnet_ids = aws_subnet.private[*].id

  # count specifies the number of instances to create;
  # if var.elasticache is true then the resource is enabled
  count = var.elasticache ? 1 : 0
}

# Create the ElastiCache (Redis) replication group
resource "aws_elasticache_replication_group" "redis_cart" {
  replication_group_id = "${var.name}-redis-cart"
  description          = "Redis cache for Online Boutique cart service"
  node_type            = "cache.t3.micro"
  num_cache_clusters   = 1
  port                 = 6379
  engine_version       = "7.0"
  parameter_group_name = "default.redis7"
  subnet_group_name    = aws_elasticache_subnet_group.redis[0].name

  security_group_ids = [aws_security_group.redis.id]

  # count specifies the number of instances to create;
  # if var.elasticache is true then the resource is enabled
  count = var.elasticache ? 1 : 0

  depends_on = [
    aws_elasticache_subnet_group.redis,
  ]
}

# Security group for ElastiCache Redis
resource "aws_security_group" "redis" {
  name_prefix = "${var.name}-redis-"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-redis-sg"
  }
}

# Edit contents of kustomization.yaml file to target new ElastiCache Redis instance
resource "null_resource" "kustomization_update" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = "sed -i \"s/REDIS_CONNECTION_STRING/${aws_elasticache_replication_group.redis_cart[0].primary_endpoint_address}:6379/g\" ../kustomize/components/memorystore/kustomization.yaml"
  }

  # count specifies the number of instances to create;
  # if var.elasticache is true then the resource is enabled
  count = var.elasticache ? 1 : 0

  depends_on = [
    aws_elasticache_replication_group.redis_cart,
  ]
}
