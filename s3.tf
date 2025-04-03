resource "aws_s3_bucket" "bucket1" {
  bucket = "buket8746104"
  force_destroy = true

  tags = {
    Name        = "S3 bucket"
  }
}