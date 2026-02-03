variable "vpc_id" {}
variable "public_subnets" { type = list(string) }
variable "app_subnets" { type = list(string) }
variable "alb_sg_id" {}
variable "app_sg_id" {}
variable "project_name" {}