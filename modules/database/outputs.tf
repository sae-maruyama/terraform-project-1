output "db_instance_id" {
  description = "RDSインスタンスのID"
  value       = aws_db_instance.main.id
}

output "db_endpoint" {
  description = "RDSエンドポイント"
  value       = aws_db_instance.main.endpoint
}

output "db_port" {
  description = "RDSポート番号"
  value       = aws_db_instance.main.port
}

output "db_name" {
  description = "データベース名"
  value       = aws_db_instance.main.db_name
}

output "db_username" {
  description = "データベースユーザー名"
  value       = aws_db_instance.main.username
  sensitive   = true
}

output "master_user_secret_arn" {
  description = "Secrets Managerのシークレット ARN"
  value       = aws_db_instance.main.master_user_secret[0].secret_arn
}

output "master_user_secret_status" {
  description = "Secrets Managerのシークレット ステータス"
  value       = aws_db_instance.main.master_user_secret[0].secret_status
}