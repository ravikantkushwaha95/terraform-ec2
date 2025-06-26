
output "ec2_public_id" {
  value       = aws_instance.rk-instance.public_ip
  description = "Public IP Address for EC@"
}
