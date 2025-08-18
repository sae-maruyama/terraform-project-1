# DB Subnet Group
resource "aws_db_subnet_group" "main" {
  name       = "${var.name_prefix}-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.name_prefix}-db-subnet-group"
  }
}

# RDS Instance
resource "aws_db_instance" "main" {
  # 基本設定
  identifier        = "${var.name_prefix}-mysql-db"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  storage_type      = "gp3"
  storage_encrypted = true

  # データベース設定
  db_name  = var.db_name
  username = var.db_username

  # AWS管理のマスターパスワード
  manage_master_user_password   = true
  master_user_secret_kms_key_id = null # デフォルトKMSキーを使用

  # ネットワーク設定
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.security_group_id]
  publicly_accessible    = false

  # バックアップ設定
  backup_retention_period = 7
  backup_window           = "03:00-04:00"
  maintenance_window      = "sun:04:00-sun:05:00"

  # スナップショット設定
  skip_final_snapshot      = true
  delete_automated_backups = true

  # その他設定
  auto_minor_version_upgrade = true
  deletion_protection        = false

  # ライフサイクル保護
  lifecycle {
    prevent_destroy = true # 誤削除防止
  }

  tags = {
    Name = "${var.name_prefix}-mysql-db"
    Type = "RDS-MySQL"
  }
}
