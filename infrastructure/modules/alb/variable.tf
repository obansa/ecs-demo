variable "vpc_id" {
  description = "VPC ID for ALB resources"
  type        = string
}


variable "subnets" {
  type = list(string)
}