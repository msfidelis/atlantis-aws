data "template_file" "user_data" {
  template = file("./user-data.sh")
  vars = {
    region       = var.aws_region
    docker_name  = var.project_name
    efs          = aws_efs_file_system.main.id
    docker_image = format("%s:latest", aws_ecr_repository.registry.repository_url)
  }
}

data "aws_ami" "main" {
  most_recent = true
  filter {
    name   = "name"
    values = [var.ami]
  }
  owners = [var.ami_owner]
}


data "aws_iam_policy_document" "ec2_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy_document" "ec2_policy" {
  statement {
    effect = "Allow"
    actions = [
      "elasticfilesystem:ClientMount",
      "elasticfilesystem:ClientWrite",
      "elasticfilesystem:ClientRootAccess",
      "*"
    ]

    resources = [
      "*"
    ]
  }
}
