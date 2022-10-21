variable "instance_type" {
  type = string
  description = "instance type"
  default     = "t3.micro"
}

variable "launch_template_name" {
  type = string
  description = "instance type"
  default     = "galp-test
}

variable "public_subnet" {
  type = list(string)
  description = "public subnet"
  default     = []
}

variable "private_subnet" {
  type = list(string)
  description = "private_subnet"
  default     = []
}


variable "environment" {
  type = string
  description = "environment"
  default = "galp-test"
}

variable "subnet_count" {
  type = number
  default = 6
}

variable "bastion_subnet" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr_block" {
  type = list(string)
}

