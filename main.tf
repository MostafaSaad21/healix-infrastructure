# 1. Network
module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = var.vpc_cidr
  project_name = var.project_name
}

# 2. Security
module "security" {
  source       = "./modules/security"
  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
}

# 3. Database
module "database" {
  source            = "./modules/database"
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.vpc.private_data_subnets
  db_sg_id          = module.security.db_sg_id
  redis_sg_id       = module.security.redis_sg_id
  replica_count     = 2
  project_name      = var.project_name
  db_username       = var.db_username
  db_password       = var.db_password
}

# 4. Compute
module "compute" {
  source            = "./modules/compute"
  vpc_id            = module.vpc.vpc_id
  public_subnets    = module.vpc.public_subnets
  app_subnets       = module.vpc.private_app_subnets
  alb_sg_id         = module.security.alb_sg_id
  app_sg_id         = module.security.app_sg_id
  project_name      = var.project_name
}

# 5. Edge (Global)
module "edge" {
  source       = "./modules/edge"
  alb_dns_name = module.compute.alb_dns_name
  project_name = var.project_name
}