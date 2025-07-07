# --- root/outputs.tf ---

# VPC Outputs
output "vpc_id_active" {
  description = "VPC ID in active region"
  value       = module.vpc1.vpc_id_active
}

output "vpc_id_pilot" {
  description = "VPC ID in pilot region"
  value       = module.vpc1.vpc_id_pilot
}

output "alb_sg_id_active" {
  value       = module.security-group.alb_sg_id_active
  description = "ALB Security Group ID in Active region"
}

output "asg_sg_id_active" {
  value       = module.security-group.asg_sg_id_active
  description = "ASG Security Group ID in Active region"
}

output "rds_sg_id_active" {
  value       = module.security-group.rds_sg_id_active
  description = "RDS Security Group ID in Active region"
}

output "alb_sg_id_pilot" {
  value       = module.security-group.alb_sg_id_pilot
  description = "ALB Security Group ID in Pilot region"
}

output "asg_sg_id_pilot" {
  value       = module.security-group.asg_sg_id_pilot
  description = "ASG Security Group ID in Pilot region"
}

output "rds_sg_id_pilot" {
  value       = module.security-group.rds_sg_id_pilot
  description = "RDS Security Group ID in Pilot region"
}


# # ALB Outputs
output "alb_dns_name_active" {
  description = "DNS name of the ALB in the active region"
  value       = module.alb.alb_dns_name_active
}

output "alb_dns_name_pilot" {
  description = "DNS name of the ALB in the pilot region"
  value       = module.alb.alb_dns_name_pilot
}
output "alb_target_group_arn_active" {
  description = "Target group ARN in active region"
  value       = module.alb.target_group_arn_active
}

output "alb_target_group_arn_pilot" {
  description = "Target group ARN in pilot region"
  value       = module.alb.target_group_arn_pilot
}


# # EC2 Auto Scaling Outputs
output "ec2_asg_active_name" {
  description = "Auto Scaling Group name in the active region"
  value       = module.ec2_asg.asg_name_active
}

output "ec2_asg_pilot_name" {
  description = "Auto Scaling Group name in the pilot region"
  value       = module.ec2_asg.asg_name_pilot
}

# # S3 Bucket Outputs
output "s3_bucket_active" {
  description = "ID of the active S3 bucket"
  value       = module.s3.bucket_active_id
}

output "s3_bucket_pilotlight" {
  description = "ID of the pilot light S3 bucket"
  value       = module.s3.bucket_pilot_id
}

output "s3_replication_role_arn" {
  description = "ARN of the replication role used in S3 CRR"
  value       = module.s3.replication_role_arn
}

# # RDS Outputs
output "rds_endpoint_active" {
  description = "RDS endpoint in the active region"
  value       = module.rds.rds_endpoint_active
}

output "rds_endpoint_pilot" {
  description = "RDS endpoint in the pilot region"
  value       = module.rds.rds_endpoint_pilot
}


# # Route53 DNS
# output "route53_record_active" {
#   description = "Route53 DNS record for active region"
#   value       = module.route53.record_active
# }

# output "route53_record_pilot" {
#   description = "Route53 DNS record for pilot region"
#   value       = module.route53.record_pilot
# }
