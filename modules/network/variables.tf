# modules/network/variables.tf

variable "vpc_cidr" {
  description = "VPCのCIDRブロック"
  type        = string
  default     = "10.0.0.0/21"
}

variable "subnet_cidrs" {
  description = "各サブネットのCIDRブロック"
  type = object({
    web   = string
    api   = string
    db    = string
    db_2  = string
    elb_1 = string
    elb_2 = string
  })
  default = {
    web   = "10.0.0.0/24"
    api   = "10.0.1.0/24"
    db    = "10.0.2.0/24"
    db_2  = "10.0.5.0/24"
    elb_1 = "10.0.3.0/24"
    elb_2 = "10.0.4.0/24"
  }
}

variable "name_prefix" {
  description = "リソース名のプレフィックス"
  type        = string
}