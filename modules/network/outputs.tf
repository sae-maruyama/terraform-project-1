
# modules/network/outputs.tf

output "vpc_id" {
  description = "VPCのID"
  value       = aws_vpc.main.id
}

# 個別サブネット情報
output "web_subnet_id" {
  description = "WebサブネットのID"
  value       = aws_subnet.web.id
}

output "api_subnet_id" {
  description = "APIサブネットのID"
  value       = aws_subnet.api.id
}

output "db_subnet_id" {
  description = "DBサブネットのID"
  value       = aws_subnet.db.id
}

output "elb_subnet_1_id" {
  description = "ELBサブネット1のID"
  value       = aws_subnet.elb_1.id
}

output "elb_subnet_2_id" {
  description = "ELBサブネット2のID"
  value       = aws_subnet.elb_2.id
}

output "db_subnet_2_id" {
  description = "DBサブネット2のID（RDS用）"
  value       = aws_subnet.db_2.id
}
