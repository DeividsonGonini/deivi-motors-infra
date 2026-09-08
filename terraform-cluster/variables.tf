variable "projectName" {
  default = "deivi-motors"
}

variable "region" {
  description = "Região da AWS Norte da Virginia"
  type        = string
  default     = "us-east-1"
}


variable "cidr_vpc" {
  default = "10.0.0.0/16"
}


variable "police_arn" {
  default = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
}

variable "instance_type" {
  default = "t3.small"
}

variable "deivi_motors_mongo_db_user" {
  description = "usuario deivi_motors_db_mongo"
  sensitive = true
}

variable "deivi_motors_mongo_db_password" {
  description = "Password deivi_motors_db_mongo"
  sensitive = true
}

variable "bucket_tfstate" {
  description = "Nome do bucket onde fica salvo os tfstates do projeto"
  type        = string
  default     = "tfstate-infra-deivi-motors"
}