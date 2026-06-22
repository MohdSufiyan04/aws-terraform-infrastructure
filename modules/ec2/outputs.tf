# Exposing the public IP so we can access the app after deployment
output "public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.main.public_ip
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.main.id
}