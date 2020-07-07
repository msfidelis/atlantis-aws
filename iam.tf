resource "aws_iam_role" "ec2_role" {
  name               = format("%s_role", var.project_name)
  assume_role_policy = data.aws_iam_policy_document.ec2_role.json
}

resource "aws_iam_role_policy" "ec2_execution_role_policy" {
  name   = format("%s_policy", var.project_name)
  policy = data.aws_iam_policy_document.ec2_policy.json
  role   = aws_iam_role.ec2_role.id
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = format("%s_ec2", var.project_name)
  role = aws_iam_role.ec2_role.id
}