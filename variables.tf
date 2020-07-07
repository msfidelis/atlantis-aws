variable "project_name" {
  default = "atlantis"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "aws_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

variable "ami" {
  default = "amzn2-ami-hvm-2.0.*-x86_64-gp2"
}

variable "ami_owner" {
  default = "amazon"
}

variable "instance_type" {
  default = "t3.large"
}

variable "auto_scale" {
  default = {
    max = 2
    min = 1
  }
}

variable "health_check_grace_period" {
  default = 300
}