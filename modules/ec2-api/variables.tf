# modules/ec2-api/variables.tf

variable "subnet_id" {
  description = "EC2インスタンスを配置するサブネットのID"
  type        = string
}

variable "security_group_id" {
  description = "EC2インスタンスに割り当てるセキュリティグループのID"
  type        = string
}

variable "name_prefix" {
  description = "リソース名のプレフィックス"
  type        = string
}

variable "instance_type" {
  description = "EC2インスタンスタイプ"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "EC2インスタンスに割り当てるキーペア名"
  type        = string
}

variable "iam_instance_profile_name" {
  description = "EC2インスタンスに割り当てるIAMインスタンスプロファイル名"
  type        = string
}
