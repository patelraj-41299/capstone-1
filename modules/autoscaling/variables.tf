variable "launch_template_id" {
  type        = string
  description = "ID of the Launch Template"
}

variable "target_group_arn" {
  type        = string
  description = "ARN of the ALB target group"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for ASG"
}

variable "desired_capacity" {
  type        = number
  default     = 2
}

variable "min_size" {
  type        = number
  default     = 2
}

variable "max_size" {
  type        = number
  default     = 3
}