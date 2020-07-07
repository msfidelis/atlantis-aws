resource "aws_vpc" "main" {
  cidr_block    = "12.0.0.0/16"

  enable_dns_hostnames  = true
  enable_dns_support    = true

  tags = {
      Name = format("%s-vpc", var.project_name)
  }
}

resource "aws_subnet" "public_subnet_1a" {
  vpc_id = aws_vpc.main.id

  cidr_block                = "12.0.0.0/24"
  map_public_ip_on_launch   = true
  availability_zone     = format("%sa", var.aws_region)

  tags = {
      "Name" = format("%s-public-1a", var.project_name),
  }
}

resource "aws_subnet" "public_subnet_1c" {
  vpc_id = aws_vpc.main.id

  cidr_block                = "12.0.16.0/24"
  map_public_ip_on_launch   = true
  availability_zone     = format("%sc", var.aws_region)

  tags = {
      "Name" = format("%s-public-1c", var.project_name),
  }
}

resource "aws_route_table_association" "public_1a" {
  subnet_id = aws_subnet.public_subnet_1a.id
  route_table_id = aws_route_table.igw_route_table.id
}

resource "aws_route_table_association" "public_1c" {
  subnet_id = aws_subnet.public_subnet_1c.id
  route_table_id = aws_route_table.igw_route_table.id
}