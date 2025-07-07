#https://registry.terraform.io/providers/hashicorp/aws/latest

# --- root/main.tf ---

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
  required_version = ">= 1.3"
}

provider "aws" {
  alias  = "active"
  region = var.region_active
}

provider "aws" {
  alias  = "pilot"
  region = var.region_pilot
}

# --- VPC ---
module "vpc1" {
  source = "./modules/vpc1"

  region_active = var.region_active
  region_pilot  = var.region_pilot

  vpc_cidr_active  = var.vpc_cidr_active
  vpc_cidr_pilot   = var.vpc_cidr_pilot

  az_active_a = var.az_active_a
  az_active_b = var.az_active_b
  az_pilot_a  = var.az_pilot_a
  az_pilot_b  = var.az_pilot_b

  public_subnet_active_a  = var.public_subnet_active_a
  public_subnet_active_b  = var.public_subnet_active_b
  private_subnet_active_a = var.private_subnet_active_a
  private_subnet_active_b = var.private_subnet_active_b

  public_subnet_pilot_a  = var.public_subnet_pilot_a
  public_subnet_pilot_b  = var.public_subnet_pilot_b
  private_subnet_pilot_a = var.private_subnet_pilot_a
  private_subnet_pilot_b = var.private_subnet_pilot_b
}

# --- ALB ---

module "alb" {
  source = "./modules/alb"

  region_active = var.region_active
  region_pilot  = var.region_pilot

  vpc_id_active = module.vpc1.vpc_id_active
  vpc_id_pilot  = module.vpc1.vpc_id_pilot

  public_subnet_ids_active = module.vpc1.public_subnet_ids_active
  public_subnet_ids_pilot  = module.vpc1.public_subnet_ids_pilot

  security-group_ids_active = [module.security-group.active_alb_sg_id]
  security-group_ids_pilot  = [module.security-group.pilot_alb_sg_id]
}


# # --- EC2 + ASG ---
module "ec2_asg" {
  source = "./modules/ec2_asg"

  region_active = var.region_active
  region_pilot  = var.region_pilot

  private_subnet_ids_active = module.vpc1.private_subnet_ids_active
  private_subnet_ids_pilot  = module.vpc1.private_subnet_ids_pilot

  security_group_ids_active = [module.security-group.active_asg_sg_id]
  security_group_ids_pilot  = [module.security-group.pilot_asg_sg_id]

  vpc_id_active             = module.vpc1.vpc_id_active
  vpc_id_pilot              = module.vpc1.vpc_id_pilot

  target_group_arn_active   = module.alb.target_group_arn_active
  target_group_arn_pilot    = module.alb.target_group_arn_pilot
  ami_id_active             = var.ami_id_active
  ami_id_pilot              = var.ami_id_pilot
  key_name_active           = var.key_name_active
  key_name_pilot            = var.key_name_pilot
}

# # --- Security Groups Module ---
module "security-group" {
  source = "./modules/security-group"
  region_active     = var.region_active
  region_pilot      = var.region_pilot
  vpc_id_active = module.vpc1.vpc_id_active
  vpc_id_pilot  = module.vpc1.vpc_id_pilot
}

# --- S3 Buckets + Replication ---
module "s3" {
  source = "./modules/s3"

  vpc_id_active = module.vpc1.vpc_id_active
  vpc_id_pilot  = module.vpc1.vpc_id_pilot
  #region_active     = var.region_active
  #region_pilot      = var.region_pilot
  bucket_active_name = var.bucket_active_name
  bucket_pilot_name = var.bucket_pilot_name
}

# # --- RDS ---
module "rds" {
  source = "./modules/rds"

  region_active              = var.region_active
  region_pilot               = var.region_pilot
  private_subnet_ids_active = module.vpc1.private_subnet_ids_active
  private_subnet_ids_pilot  = module.vpc1.private_subnet_ids_pilot
  rds_sg_id_active          = module.security-group.active_rds_sg_id
  rds_sg_id_pilot           = module.security-group.pilot_rds_sg_id

  db_username = var.db_username
  db_password = var.db_password
  db_name     = var.db_name
}

# # --- Route53 ---
# module "route53" {
#   source = "../route53"

#   domain_name       = var.domain_name
#   alb_dns_active    = module.alb.alb_dns_name_active
#   alb_dns_pilot     = module.alb.alb_dns_name_pilot
#   health_check_path = var.health_check_path
# }
