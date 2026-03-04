resource "aws_ecr_repository" "app_repo" {
  name = var.ecr_repo_name

  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = var.environment
    Project     = var.ecr_repo_name
  }
}
#resource "aws_s3_bucket" "test_bucket" {
#  bucket = "${var.project_name}-test-bucket-123456141099"
#}

