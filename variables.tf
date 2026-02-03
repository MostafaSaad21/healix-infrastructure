variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project Name Prefix"
  default     = "healix-medical"
}

variable "environment" {
  description = "Deployment Environment (dev, stage, prod)"
  default     = "prod"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "db_username" {
  description = "Master database username"
  type        = string
  default     = "admin" # ممكن تحط قيمة افتراضية للاسم عادي
}

variable "db_password" {
  description = "Master database password"
  type        = string
  sensitive   = true
  # ⚠️ متكتبش default للباسورد هنا للأمان
}