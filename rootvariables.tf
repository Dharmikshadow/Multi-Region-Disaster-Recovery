#Regions
variable "region_active" {
  description = "AWS region for the active environment"
  type        = string
}

variable "region_pilot" {
  description = "AWS region for the pilot light environment"
  type        = string
}

# VPC
variable "vpc_cidr_active" {
  description = "CIDR block for the active region VPC"
  type        = string
}

variable "vpc_cidr_pilot" {
  description = "CIDR block for the pilot region VPC"
  type        = string
}

variable "az_active_a" {
  description = "First AZ for active region"
  type        = string
}

variable "az_active_b" {
  description = "Second AZ for active region"
  type        = string
}

variable "az_pilot_a" {
  description = "First AZ for pilot region"
  type        = string
}

variable "az_pilot_b" {
  description = "Second AZ for pilot region"
  type        = string
}

# Subnets
variable "public_subnet_active_a" {
   type = string 
}
variable "public_subnet_active_b" { 
  type = string 
}
variable "private_subnet_active_a" { 
  type = string 
}
variable "private_subnet_active_b" { 
  type = string 
}

variable "public_subnet_pilot_a" { 
  type = string
}
variable "public_subnet_pilot_b" { 
  type = string
}
variable "private_subnet_pilot_a" { 
  type = string
}
variable "private_subnet_pilot_b" { 
  type = string 
}

# EC2 & ASG
variable "ami_id_active" { 
  type = string 
}
variable "ami_id_pilot" { 
  type = string 
}
variable "key_name_active" { 
  type = string 
}
variable "key_name_pilot" { 
  type = string 
}

# S3
variable "bucket_active_name" {
  description = "Name of the source bucket"
  type        = string
}

variable "bucket_pilot_name" {
  description = "Name of the destination bucket"
  type        = string
}

# # RDS
variable "db_username" {
  description = "Database master username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database master password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Initial database name"
  type        = string
}

variable "vpc_id_active" {
  description = "VPC ID for the active region"
  type        = string
}

variable "vpc_id_pilot" {
  description = "VPC ID for the pilot region"
  type        = string
}

# # Route 53
# variable "domain_name" {
#   description = "DNS domain name"
#   type        = string
# }

# variable "health_check_path" {
#   description = "Path used for Route 53 health checks"
#   type        = string
# }
