# outputs.tf (ルートディレクトリ)

output "vpc_id" {
  description = "作成されたVPCのID"
  value       = module.network.vpc_id
}

output "subnet_ids" {
  description = "作成されたサブネットのID一覧"
  value = {
    web   = module.network.web_subnet_id
    api   = module.network.api_subnet_id
    db    = module.network.db_subnet_id
    elb_1 = module.network.elb_subnet_1_id
    elb_2 = module.network.elb_subnet_2_id
    db_2  = module.network.db_subnet_2_id
  }
}

output "security_group_ids" {
  description = "作成されたセキュリティグループのID一覧"
  value = {
    web = module.security.web_security_group_id
    api = module.security.api_security_group_id
    elb = module.security.elb_security_group_id
    db  = module.security.db_security_group_id
  }
}

output "alb_dns_name" {
  description = "ALBのDNS名"
  value       = module.alb.alb_dns_name
}

output "alb_url" {
  description = "ALBのURL"
  value       = "http://${module.alb.alb_dns_name}"
}

output "db_endpoint" {
  description = "RDSエンドポイント"
  value       = module.database.db_endpoint
}

output "db_secret_arn" {
  description = "RDSマスターパスワードのSecrets Manager ARN"
  value       = module.database.master_user_secret_arn
}

# API EC2でのデータベース接続情報
output "api_connection_info" {
  description = "API EC2からのデータベース接続情報"
  value = {
    endpoint   = module.database.db_endpoint
    port       = module.database.db_port
    database   = module.database.db_name
    username   = module.database.db_username
    secret_arn = module.database.master_user_secret_arn
  }
  sensitive = true
}

output "autoscaling_info" {
  description = "Auto Scaling Group情報"
  value = {
    group_name = module.autoscaling.autoscaling_group_name
    min_size   = 1
    max_size   = 3
    desired    = 2
  }
}
