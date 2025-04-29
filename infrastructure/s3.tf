resource "aws_s3_bucket" "artifact_bucket" {
  bucket = "capstone-artifact-bucket-${random_id.suffix.hex}"
  force_destroy = true
}

resource "random_id" "suffix" {
  byte_length = 4
}
