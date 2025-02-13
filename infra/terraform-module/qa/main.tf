provider "aws" {
  region = var.region
}

module "vpc" {
  source              = "../modules/vpc"
  cidr_block          = var.vpc_cidr
  name                = "qa-${var.vpc_name}"
  public_subnets      = var.public_subnets
  public_azs          = var.public_azs
  private_subnets     = var.private_subnets
  private_azs         = var.private_azs
  eks_nodes_cidr_blocks = var.eks_nodes_cidr_blocks
}

module "iam" {
  source              = "../modules/iam"
  cluster_role_name   = "qa-${var.cluster_role_name}"
  cluster_policy_arns = var.cluster_policy_arns
  node_role_name      = "qa-${var.node_role_name}"
  node_policy_arns    = var.node_policy_arns
}

module "eks" {
  source              = "../modules/eks"
  cluster_name        = "qa-${var.cluster_name}"
  cluster_version     = var.cluster_version
  cluster_subnet_ids  = [module.vpc.public_subnets_ids[1]]
  node_subnet_ids     = [module.vpc.private_subnets_ids[1]]
  cluster_role_arn    = module.iam.cluster_role_arn
  node_role_arn       = module.iam.node_role_arn
  node_desired_capacity = var.node_desired_capacity
  node_max_capacity     = var.node_max_capacity
  node_min_capacity     = var.node_min_capacity
  node_instance_type    = var.node_instance_type
  max_unavailable       = var.max_unavailable
}

module "jenkins" {
  source            = "../modules/jenkins"
  ami_id            = var.jenkins_ami_id
  instance_type     = var.jenkins_instance_type
  subnet_id         = module.vpc.public_subnets_ids[0]
  key_name          = var.key_name
  volume_size       = var.jenkins_volume_size
  security_group_id = module.vpc.jenkins_sg_id
  name              = "qa-jenkins-instance"
}

module "rds" {
  source              = "../modules/rds"
  subnet_group_name   = "qa-${var.rds_subnet_group_name}"
  subnet_ids          = [module.vpc.private_subnets_ids[0]]
  db_identifier       = "qa-${var.rds_db_identifier}"
  instance_class      = var.rds_instance_class
  allocated_storage   = var.rds_allocated_storage
  security_group_id   = module.vpc.rds_sg_id
  deletion_protection = var.rds_deletion_protection
  monitoring_interval = var.rds_monitoring_interval
  username            = var.rds_username
  password            = var.rds_password
}

module "alb" {
  source              = "../modules/alb"
  lb_name             = "qa-${var.lb_name}"
  lb_security_groups  = var.lb_security_groups
  subnet_ids          = module.vpc.public_subnets_ids
  environment         = "qa"
  target_group_name   = var.target_group_name
  target_port         = var.target_port
  target_protocol     = var.target_protocol
  health_check_path   = var.health_check_path
  listener_port       = var.listener_port
  listener_protocol   = var.listener_protocol
  vpc_id              = module.vpc.vpc_id
}

module "ecr_sockshop_carts" {
  source          = "../modules/ecr"
  repository_name = "qa-${var.ecr_repository_name_carts}"
  environment     = "qa"
}

module "ecr_sockshop_orders" {
  source          = "../modules/ecr"
  repository_name = "qa-${var.ecr_repository_name_orders}"
  environment     = "qa"
}

module "cloudwatch" {
  source            = "../modules/cloudwatch"
  log_group_name    = "/aws/eks/qa-${var.cloudwatch_log_group_name}"
  retention_in_days = var.cloudwatch_retention_in_days
  tags              = var.cloudwatch_tags
}

module "route53" {
  source      = "../modules/route53"
  domain_name = "csrnet.nz"
  record_name = "www"
  record_type = "A"
  ttl         = 300
  records     = [module.alb.lb_dns_name]
}