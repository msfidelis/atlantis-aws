resource "aws_launch_template" "main" {
    name        = var.project_name
    image_id    = data.aws_ami.main.id
    
    instance_type = var.instance_type

    block_device_mappings {
        device_name = "/dev/sda1"

        ebs {
            volume_size = 20
        }
    }

    user_data   = base64encode(data.template_file.user_data.rendered)   

    vpc_security_group_ids = [
        aws_security_group.ec2_sg.id
    ]

    tag_specifications {
        resource_type = "instance"

        tags = {
            Name = "atlantis"
        }
    }    

    key_name = aws_key_pair.main.key_name

    iam_instance_profile {
        name = aws_iam_instance_profile.ec2_profile.name
    }
    
}