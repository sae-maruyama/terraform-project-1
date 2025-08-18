# modules/security/variables.tf

variable "vpc_id" {
  description = "VPCのID"
  type        = string
}

variable "name_prefix" {
  description = "リソース名のプレフィックス"  
  type        = string
}