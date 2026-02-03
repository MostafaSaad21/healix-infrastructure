variable "vpc_id" {}
variable "subnet_ids" { type = list(string) }
variable "db_sg_id" {}
variable "redis_sg_id" {}
variable "replica_count" { default = 1 }
variable "project_name" {}
variable "db_username" {
  description = "Username for the master DB user"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Password for the master DB user"
  type        = string
  sensitive   = true
}