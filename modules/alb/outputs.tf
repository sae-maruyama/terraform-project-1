output "alb_arn" {
  description = "ALBのARN"
  value       = aws_lb.api.arn
}

output "alb_dns_name" {
  description = "ALBのDNS名"
  value       = aws_lb.api.dns_name
}

output "alb_zone_id" {
  description = "ALBのホストゾーンID"
  value       = aws_lb.api.zone_id
}

output "target_group_arn" {
  description = "ターゲットグループのARN"
  value       = aws_lb_target_group.api.arn
}