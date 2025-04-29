output "alb_dns_name" { value = aws_lb.app.dns_name }
output "dynamodb_table_name" { value = aws_dynamodb_table.webapp_table.name }
