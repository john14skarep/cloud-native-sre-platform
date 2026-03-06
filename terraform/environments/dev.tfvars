environment = "dev"

ecr_repo_name = "cloud-native-sre-platform-dev"

terraform destroy -var-file=environments/dev.tfvars -lock=false

terraform apply -var-file=environments/dev.tfvars -lock=false