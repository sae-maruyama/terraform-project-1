variable "name_prefix" {
  description = "リソース名のプレフィックス"
  type        = string
}

variable "ami_id" {
  description = "Launch Templateで使用するAMI ID"
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

variable "security_group_id" {
  description = "EC2インスタンスに割り当てるセキュリティグループのID"
  type        = string
}

variable "iam_instance_profile_name" {
  description = "EC2インスタンスに割り当てるIAMインスタンスプロファイル名"
  type        = string
}

variable "subnet_ids" {
  description = "Auto Scaling Groupが使用するサブネットのIDリスト"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ALBターゲットグループのARN"
  type        = string
}

variable "min_size" {
  description = "Auto Scaling Groupの最小インスタンス数"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Auto Scaling Groupの最大インスタンス数"
  type        = number
  default     = 3
}

variable "desired_capacity" {
  description = "Auto Scaling Groupの希望インスタンス数"
  type        = number
  default     = 2
}