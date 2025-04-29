data "aws_vpc" "existing" {
  filter {
    name   = "tag:Name"
    values = ["capstone-vpc"]
  }
}

data "aws_subnet" "public_subnet1" {
  filter {
    name   = "tag:Name"
    values = ["public-subnet-1"]
  }
}

data "aws_subnet" "public_subnet2" {
  filter {
    name   = "tag:Name"
    values = ["public-subnet-2"]
  }
}

data "aws_security_group" "alb_sg" {
  filter {
    name   = "group-name"
    values = ["alb-sg"]
  }
}

data "aws_security_group" "ec2_sg" {
  filter {
    name   = "group-name"
    values = ["ec2-sg"]
  }
}
