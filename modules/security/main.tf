# modules/security/main.tf

# ELB Security Group
resource "aws_security_group" "elb" {
  name_prefix = "${var.name_prefix}-elb-sg-"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.name_prefix}-elb-sg"
  }
}

# Web Security Group  
resource "aws_security_group" "web" {
  name_prefix = "${var.name_prefix}-web-sg-"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.name_prefix}-web-sg"
  }
}

# API Security Group
resource "aws_security_group" "api" {
  name_prefix = "${var.name_prefix}-api-sg-"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.name_prefix}-api-sg"
  }
}

# DB Security Group
resource "aws_security_group" "db" {
  name_prefix = "${var.name_prefix}-db-sg-"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.name_prefix}-db-sg"
  }
}

# Security Group Rules - インバウンド

# ELB: HTTP 80 from 0.0.0.0/0
resource "aws_security_group_rule" "elb_ingress_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.elb.id
  description       = "HTTP from internet"
}

# Web: HTTP 80 from 0.0.0.0/0
resource "aws_security_group_rule" "web_ingress_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web.id
  description       = "HTTP from internet"
}

# Web: SSH 22 from 0.0.0.0/0
resource "aws_security_group_rule" "web_ingress_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web.id
  description       = "SSH from internet"
}

# API: HTTP 80 from ELB
resource "aws_security_group_rule" "api_ingress_http" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.elb.id
  security_group_id        = aws_security_group.api.id
  description              = "HTTP from ELB"
}

resource "aws_security_group_rule" "api_ingress_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web.id
  security_group_id        = aws_security_group.api.id
  description              = "SSH from Web server"
}

# DB: MySQL 3306 from API
resource "aws_security_group_rule" "db_ingress_mysql" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.api.id
  security_group_id        = aws_security_group.db.id
  description              = "MySQL from API"
}

# Security Group Rules - アウトバウンド（すべて許可）

# ELB: すべて許可
resource "aws_security_group_rule" "elb_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.elb.id
  description       = "All outbound traffic"
}

# Web: すべて許可
resource "aws_security_group_rule" "web_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web.id
  description       = "All outbound traffic"
}

# API: すべて許可
resource "aws_security_group_rule" "api_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.api.id
  description       = "All outbound traffic"
}

# DB: すべて許可
resource "aws_security_group_rule" "db_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.db.id
  description       = "All outbound traffic"
}