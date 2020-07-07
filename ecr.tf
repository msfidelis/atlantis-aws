resource "aws_ecr_repository" "registry" {
    name = var.project_name
}