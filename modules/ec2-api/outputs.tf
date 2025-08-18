# modules/ec2-api/outputs.tf

output "instance_id" {
  description = "APIサーバーのインスタンスID"
  value       = aws_instance.api.id
}

output "private_ip" {
  description = "APIサーバーのプライベートIP"
  value       = aws_instance.api.private_ip
}

output "private_dns" {
  description = "APIサーバーのプライベートDNS"
  value       = aws_instance.api.private_dns
}