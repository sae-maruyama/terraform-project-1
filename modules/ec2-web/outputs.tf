# modules/ec2-web/outputs.tf

output "instance_id" {
  description = "WebサーバーのインスタンスID"
  value       = aws_instance.web.id
}

output "public_ip" {
  description = "WebサーバーのパブリックIP"
  value       = aws_instance.web.public_ip
}

output "private_ip" {
  description = "WebサーバーのプライベートIP"
  value       = aws_instance.web.private_ip
}

output "public_dns" {
  description = "WebサーバーのパブリックDNS"
  value       = aws_instance.web.public_dns
}