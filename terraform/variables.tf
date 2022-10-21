variable "subnet_count" {
  description = "number of subnets"
  type = number
}

variable "name" {
  description = "name will be used as name for all resources"
  type = string
}

variable "region" {
  description = "AWS region"
  type = string
  default = "us-east-1"
}
