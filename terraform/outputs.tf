output "repository_url" {
  value = aws_ecr_repository.app_repo.repository_url
}
output "load_balancer_url" {
  value = aws_lb.sre_alb.dns_name
}