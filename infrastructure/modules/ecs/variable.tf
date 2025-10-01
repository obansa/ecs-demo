variable "cluster_name" {
  description = "cluster name"
  type        = string
  default = "main-cluster"
  
}

variable "subnets" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "lb_tg_arn" {
  type = string
}

variable "lb_listener_arn" {
  type = string
}