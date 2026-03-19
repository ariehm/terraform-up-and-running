
provider "aws" {
  region = "us-east-2"
}

resource"aws_s3_bucket" "terraform_state" {
  bucket = "h4tch-test-terraform-up-and-running-state"

  # Prevent accidental deletion
  lifecycle {
    prevent_destroy = true
  }
}

# Enable versioning
resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Explicitly block public traffic
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.terraform_state.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

# Need a dynamo table for locks
resource "aws_dynamodb_table" "terraform_locks" {
  name = "h4tch-test-terraform-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# Finally - tell terraform to use s3 for the backend
terraform {
  backend "s3" {
    bucket = "h4tch-test-terraform-up-and-running-state"
    key = "global/s3/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "h4tch-test-terraform-up-and-running-locks"
    encrypt = true
  }
}
