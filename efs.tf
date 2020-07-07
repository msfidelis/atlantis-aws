resource "aws_efs_file_system" "main" {
  tags = {
    Name = var.project_name
  }
}

resource "aws_efs_mount_target" "efs_mount_target_a" {
  file_system_id = aws_efs_file_system.main.id
  subnet_id      = aws_subnet.public_subnet_1a.id
  # security_groups = [ aws_security_group.ec2_sg.id ]
}

resource "aws_efs_mount_target" "efs_mount_target_c" {
  file_system_id = aws_efs_file_system.main.id
  subnet_id      = aws_subnet.public_subnet_1c.id
  # security_groups = [ aws_security_group.ec2_sg.id ]
}