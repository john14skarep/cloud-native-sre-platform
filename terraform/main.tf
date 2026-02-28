resource "aws_ecr_repository" "app_repo" {
  name = var.project_name

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = "dev"
    Project     = var.project_name
  }
}
#resource "aws_s3_bucket" "test_bucket" {
#  bucket = "${var.project_name}-test-bucket-123456141099"
#}