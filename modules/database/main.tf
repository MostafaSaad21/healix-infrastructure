# 1. DATABASE SUBNET GROUP (Shared by RDS)
resource "aws_db_subnet_group" "db_group" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.subnet_ids
  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}

# 2. RDS MASTER INSTANCE (Write)
resource "aws_db_instance" "master" {
  identifier             = "${var.project_name}-master-db"
  allocated_storage      = 20
  max_allocated_storage  = 100
  engine                 = "sqlserver-se"
  engine_version         = "15.00"
  instance_class         = "db.m5.large"
  username               = var.db_username
  password               = var.db_password
  multi_az               = true
  db_subnet_group_name   = aws_db_subnet_group.db_group.name
  vpc_security_group_ids = [var.db_sg_id]
  skip_final_snapshot    = true
  license_model          = "license-included"
  
  backup_retention_period = 1
  tags = {
    Name = "${var.project_name}-master-db"
  }
  timeouts {
    create = "2h"   
    delete = "1h"
    update = "1h"
  }
}
# 3. RDS READ REPLICAS (Read Only)

# resource "aws_db_instance" "replica" {
#  count                  = var.replica_count
#  identifier             = "${var.project_name}-replica-${count.index + 1}"
#  replicate_source_db    = aws_db_instance.master.identifier
#  instance_class         = "db.m5.large"
#  vpc_security_group_ids = [var.db_sg_id]
#  port                   = 1433
#  skip_final_snapshot    = true
#  tags = {
#    Name = "Healix-Analytics-Node-${count.index + 1}"
#  }
#  timeouts {
#    create = "2h"   
#    delete = "1h"
#    update = "1h"
#  }
#}

# 4. ELASTICACHE (REDIS)
# Subnet Group for Redis
resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "${var.project_name}-redis-subnet-group"
  subnet_ids = var.subnet_ids
}

# Redis Cluster
resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "${var.project_name}-cache"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  engine_version       = "7.0"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids   = [var.redis_sg_id]

  tags = {
    Name = "${var.project_name}-redis"
  }
}