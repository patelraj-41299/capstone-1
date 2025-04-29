resource "aws_autoscaling_group" "app_asg" {
  name_prefix          = "capstone-asg-"
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity
  vpc_zone_identifier  = var.subnet_ids
  target_group_arns    = [var.target_group_arn]

  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "capstone-asg-instance"
    propagate_at_launch = true
  }

  tag {
    key                 = "CodeDeployRole"
    value               = "capstone-asg"
    propagate_at_launch = true
  }
}