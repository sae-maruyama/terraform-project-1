variable "name_prefix" {
  description = "リソース名のプレフィックス"
  type        = string
}

variable "subnet_ids" {
  description = "DBサブネットグループに含めるサブネットのIDリスト"
  type        = list(string)
}

variable "security_group_id" {
  description = "RDSに割り当てるセキュリティグループのID"
  type        = string
}

variable "instance_class" {
  description = "RDSインスタンスクラス"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "RDSの割り当てストレージ容量（GB）"
  type        = number
  default     = 20
}

variable "db_name" {
  description = "データベース名"
  type        = string
  default     = "testdb"
}

variable "db_username" {
  description = "データベースのマスターユーザー名"
  type        = string
  default     = "admin"
}