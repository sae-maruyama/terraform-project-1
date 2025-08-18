# modules/ec2-api/main.tf

resource "aws_instance" "api" {
  ami           = "ami-0adeceb9ebe3ac6f7" # カスタムAMI: maruko-api-ec2-ami
  instance_type = var.instance_type
  key_name      = var.key_name

  # ネットワーク設定
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = false

  # IAMインスタンスプロファイル（Secrets Manager アクセス用）
  iam_instance_profile = var.iam_instance_profile_name

  tags = {
    Name = "${var.name_prefix}-api-server-01"
    Type = "APIServer"
  }
}

