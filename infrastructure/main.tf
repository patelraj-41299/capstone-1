# -----------------------
# Application Load Balancer (ALB)
# -----------------------
resource "aws_lb" "app" {
  name               = "web-alb-new"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.alb_sg.id]
  subnets            = [
    data.aws_subnet.public_subnet1.id,
    data.aws_subnet.public_subnet2.id
  ]
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

# -----------------------
# Launch Template (for EC2 Auto Scaling Group)
# -----------------------
resource "aws_launch_template" "webapp" {
  name_prefix   = "webapp-lt-"
  image_id      = "ami-0c7217cdde317cfec"   # Amazon Linux 2 AMI ID (Update if needed)
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = filebase64("${path.module}/../scripts/userdata.sh")
  vpc_security_group_ids = [data.aws_security_group.ec2_sg.id]
}

# -----------------------
# Auto Scaling Group
# -----------------------
resource "aws_autoscaling_group" "webapp" {
  desired_capacity     = 1
  max_size             = 2
  min_size             = 1
  vpc_zone_identifier  = [
    data.aws_subnet.public_subnet1.id,
    data.aws_subnet.public_subnet2.id
  ]
  launch_template {
    id      = aws_launch_template.webapp.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.app.arn]
  health_check_type = "EC2"
}

# -----------------------
# DynamoDB Table
# -----------------------
resource "aws_dynamodb_table" "webapp_table" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}
