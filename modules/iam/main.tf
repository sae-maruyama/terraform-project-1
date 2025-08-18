# API EC2用IAMロール
resource "aws_iam_role" "api_ec2_role" {
  name = "${var.name_prefix}-api-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "${var.name_prefix}-api-ec2-role"
  }
}

# Secrets Manager読み取り権限のポリシー
resource "aws_iam_policy" "secrets_manager_read" {
  name        = "${var.name_prefix}-secrets-manager-read"
  description = "Policy to read RDS password from Secrets Manager"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = var.db_secret_arn
      }
    ]
  })
}

# ポリシーをロールにアタッチ
resource "aws_iam_role_policy_attachment" "api_secrets_manager" {
  policy_arn = aws_iam_policy.secrets_manager_read.arn
  role       = aws_iam_role.api_ec2_role.name
}

# インスタンスプロファイル
resource "aws_iam_instance_profile" "api_ec2_profile" {
  name = "${var.name_prefix}-api-ec2-profile"
  role = aws_iam_role.api_ec2_role.name
}