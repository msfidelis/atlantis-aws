resource "aws_autoscaling_group" "main" {
    name                      = var.project_name
    max_size                  = lookup(var.auto_scale, "max")
    min_size                  = lookup(var.auto_scale, "min")

    health_check_grace_period = var.health_check_grace_period
    health_check_type         = "ELB"

    vpc_zone_identifier       = [ aws_subnet.public_subnet_1a.id, aws_subnet.public_subnet_1c.id ]
    
    launch_template {
        id      = aws_launch_template.main.id
        version = "$Latest"
    }

    target_group_arns = [
        aws_alb_target_group.tg.id
    ]

    tag {
        key                 = "Name"
        value               = var.project_name
        propagate_at_launch = true
    }
}