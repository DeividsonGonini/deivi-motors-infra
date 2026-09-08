# Region & storage
variable "region" {
  description = "AWS region."
  type        = string
  default     = "us-east-1"
}

variable "bucket_tfstate" {
  description = "Nome do bucket onde fica salvo os tfstates do projeto"
  type        = string
  default     = "tfstate-infra-deivi-motors"
}