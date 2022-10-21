output "vpc_id" {
  description = "The ID of the VPC"
  value       = try(aws_vpc.vpc.id, "")
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = try(aws_vpc.vpc.arn, "")
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = try(aws_vpc.vpc.cidr_block, "")
}

output "private_subnet" {
  description = "All Subnet"
  value       = try(aws_subnet.private_subnet[*].id, "")
}

output "public_subnet" {
  description = "All Subnet"
  value       = try(aws_subnet.public_subnet[0].id, "")
}
