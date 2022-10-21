output "bastion_ip" {
  description = "The Bastion IP"
  value       = aws_instance.bastion
}

output "alb" {
  description = "The ALB hostname"
  value       = aws_lb.alb.dns_name
}
