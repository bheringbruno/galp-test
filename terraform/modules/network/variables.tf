variable "vpc_cidr" {
  description = "VPC CIDR"
  type = string
}

variable "environment" {
  description = "environment"
  type = string
}

variable "public_subnet_count" {
  description = "Public subnet count"
  type = number
}

variable "private_subnet_count" {
  description = "Private subnet count"
  type = number
}

