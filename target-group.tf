resource "aws_alb_target_group" "tg" {
    name_prefix = substr(var.project_name, 0, 5)
    port        = 4141
    vpc_id      = aws_vpc.main.id

    protocol    = "HTTP"
    target_type = "instance"

    health_check {
        healthy_threshold   = 3
        unhealthy_threshold = 10
        timeout             = 10
        interval            = 15
        matcher             = 200
        path                = "/healthz"
        port                = 4141
    }

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_alb_listener" "elasticsearch" {
  load_balancer_arn = aws_alb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.tg.arn
    type             = "forward"
  }
}
