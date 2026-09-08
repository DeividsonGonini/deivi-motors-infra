resource "aws_s3_bucket" "bucket-backend" {
  bucket = var.bucket_tfstate

  tags = {
    Name        = "tfstate"
    Environment = "Production"
  }
}

## Versionamento do State
resource "aws_s3_bucket_versioning" "backend_versioning" {
  bucket = aws_s3_bucket.bucket-backend.id

  versioning_configuration {
    status = "Enabled"
  }
}