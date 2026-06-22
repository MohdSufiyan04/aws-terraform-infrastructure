# This S3 bucket is for your APPLICATION storage
# Different from the bootstrap bucket which was for Terraform state
# Use cases: store app logs, uploads, config files etc.

resource "aws_s3_bucket" "app" {
  bucket = "${var.environment}-${var.app_name}-bucket"

  tags = {
    Name        = "${var.environment}-${var.app_name}-bucket"
    Environment = var.environment
  }
}

# Versioning — keeps history of every file uploaded
# If someone overwrites a file accidentally, you can recover it
resource "aws_s3_bucket_versioning" "app" {
  bucket = aws_s3_bucket.app.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Block all public access — app storage should never be public
resource "aws_s3_bucket_public_access_block" "app" {
  bucket                  = aws_s3_bucket.app.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}