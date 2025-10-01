variable "vpc_cider" {
  type = string
  description = "cider for main vpc"
  default = "10.0.0.0/16"
}

variable "public_sn" {
  type = string
  description = "cider for public subnet"
  default = "10.0.0.0/20"
}

variable "private_sn" {
  type = string
  description = "cider for public subnet"
  default = "10.0.16.0/20"
}

variable "public_sn_2" {
  type = string
  default = "10.0.32.0/20"
}