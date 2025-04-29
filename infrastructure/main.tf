terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

# Include your modules here
module "autoscaling" {
  source = "./modules/autoscaling"

  vpc_id             = data.aws_vpc.existing.id
  subnet_ids         = [data.aws_subnet.public_subnet1.id, data.aws_subnet.public_subnet2.id]
  security_group_ids = [data.aws_security_group.ec2_sg.id]
  key_name           = var.key_name
  instance_type      = var.instance_type
  user_data_path     = "${path.module}/scripts/userdata.sh"
}

# Application Load Balancer (ALB)
resource "aws_lb" "app" {
  name               = "web-alb-new"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.alb_sg.id]
  subnets            = [data.aws_subnet.public_subnet1.id, data.aws_subnet.public_subnet2.id]
}

resource "aws_lb_target_group" "app" {
  name     = "webapp-tg-new"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.existing.id

  health_check {
    path                = "/health"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

# DynamoDB Table
resource "aws_dynamodb_table" "webapp_table" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}
