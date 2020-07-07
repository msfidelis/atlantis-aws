resource "aws_alb" "main" {

    name            = var.project_name

    subnets = [
        aws_subnet.public_subnet_1a.id,
        aws_subnet.public_subnet_1c.id
    ]

    security_groups = [ aws_security_group.alb_sg.id ] 

    idle_timeout    = 600

    tags = {
        Name            = var.project_name
    }

}

resource "aws_security_group" "alb_sg" {

  name        = format("%s-alb", var.project_name)
  description = var.project_name
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}