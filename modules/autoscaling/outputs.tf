output "autoscaling_group_id" {
  description = "Auto Scaling GroupのID"
  value       = aws_autoscaling_group.api.id
}

output "autoscaling_group_name" {
  description = "Auto Scaling Groupの名前"
  value       = aws_autoscaling_group.api.name
}

output "autoscaling_group_arn" {
  description = "Auto Scaling GroupのARN"
  value       = aws_autoscaling_group.api.arn
}

output "launch_template_id" {
  description = "Launch TemplateのID"
  value       = aws_launch_template.api.id
}

output "launch_template_latest_version" {
  description = "Launch Templateの最新バージョン"
  value       = aws_launch_template.api.latest_version
}

output "scale_up_policy_arn" {
  description = "スケールアップポリシーのARN"
  value       = aws_autoscaling_policy.scale_up.arn
}

# output "scale_down_policy_arn" {
#   description = "スケールダウンポリシーのARN"
#   value       = aws_autoscaling_policy.scale_down.arn
# }