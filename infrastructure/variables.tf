# -----------------------
# EC2 Instance Settings
# -----------------------
variable "instance_type" {
  description = "EC2 instance type for the launch template"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name for EC2 SSH access"
  type        = string
  default     = "key-1"
}

# -----------------------
# DynamoDB Table Name
# -----------------------
variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table used by the app"
  type        = string
  default     = "mytable"
}
