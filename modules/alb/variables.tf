variable "name_prefix" {
  description = "リソース名のプレフィックス"
  type        = string
}

variable "vpc_id" {
  description = "VPCのID"
  type        = string
}

variable "subnet_ids" {
  description = "ALBを配置するサブネットのIDリスト"
  type        = list(string)
}

variable "security_group_id" {
  description = "ALBに割り当てるセキュリティグループのID"
  type        = string
}

# variable "api_instance_id" {
#   description = "ターゲットとなるAPIサーバーのインスタンスID"
#   type        = string
# }