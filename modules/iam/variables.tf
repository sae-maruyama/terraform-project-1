variable "name_prefix" {
  description = "リソース名のプレフィックス"
  type        = string
}

variable "db_secret_arn" {
  description = "RDSパスワードのSecrets Manager ARN"
  type        = string
}