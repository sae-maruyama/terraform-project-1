output "api_instance_profile_name" {
  description = "API EC2用インスタンスプロファイル名"
  value       = aws_iam_instance_profile.api_ec2_profile.name
}

output "api_role_arn" {
  description = "API EC2用IAMロールARN"
  value       = aws_iam_role.api_ec2_role.arn
}