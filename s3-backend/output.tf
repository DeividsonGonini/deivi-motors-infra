output "terraform_state_bucket" {
  description = "Bucket S3 usado para armazenar o Terraform Remote State"
  value       = aws_s3_bucket.bucket-backend.bucket
}