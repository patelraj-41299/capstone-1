resource "aws_codedeploy_app" "app" {
  name              = "capstone-app"
  compute_platform  = "Server"
}

resource "aws_codedeploy_deployment_group" "asg_group" {
  app_name               = aws_codedeploy_app.app.name
  deployment_group_name  = "capstone-asg-group"
  service_role_arn       = "arn:aws:iam::060795913786:role/CodeDeployServiceRole"
  deployment_config_name = "CodeDeployDefault.OneAtATime"
  autoscaling_groups     = [module.autoscaling.asg_name]

  load_balancer_info {
    target_group_info {
      name = "webapp-tg-new"
    }
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}
