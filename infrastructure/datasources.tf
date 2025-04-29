# ----------------------------
# Use Existing VPC
# ----------------------------
data "aws_vpc" "existing" {
  id = "vpc-01bdb0ff5014abece"
}

# ----------------------------
# Use Existing Public Subnets
# ----------------------------
data "aws_subnet" "public_subnet1" {
  id = "subnet-0aa20fa81b1a77093"
}

data "aws_subnet" "public_subnet2" {
  id = "subnet-09b8c16a6a972366d"
}

# ----------------------------
# Use Existing Security Groups
# ----------------------------
data "aws_security_group" "alb_sg" {
  id = "sg-0a3e33255796fbd86"
}

data "aws_security_group" "ec2_sg" {
  id = "sg-0e9ae490afc5b5b3f"
}
