variable "region" {
  description = "The AWS region to deploy to"
  default     = "eu-west-1"
}

variable "cpu" {
  description = "CPU units for ECS task"
  default     = "256"
}

variable "memory" {
  description = "Memory for ECS task"
  default     = "512"
}
