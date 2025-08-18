# modules/security/outputs.tf

output "web_security_group_id" {
  description = "WebサーバーのセキュリティグループID"
  value       = aws_security_group.web.id
}

output "api_security_group_id" {
  description = "APIサーバーのセキュリティグループID"
  value       = aws_security_group.api.id
}

output "elb_security_group_id" {
  description = "ELBのセキュリティグループID"
  value       = aws_security_group.elb.id
}

output "db_security_group_id" {
  description = "データベースのセキュリティグループID"
  value       = aws_security_group.db.id
}