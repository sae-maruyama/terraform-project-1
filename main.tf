# main.tf

# ネットワークモジュール
module "network" {
  source      = "./modules/network"
  name_prefix = local.name_prefix
}

# セキュリティモジュール
module "security" {
  source      = "./modules/security"
  vpc_id      = module.network.vpc_id
  name_prefix = local.name_prefix
}

# RDSモジュール
module "database" {
  source = "./modules/database"

  name_prefix       = local.name_prefix
  subnet_ids        = [module.network.db_subnet_id, module.network.db_subnet_2_id]
  security_group_id = module.security.db_security_group_id
}

# IAMモジュール (API EC2用)
module "iam" {
  source = "./modules/iam"

  name_prefix   = local.name_prefix
  db_secret_arn = module.database.master_user_secret_arn
}

# WebサーバーEC2モジュール
module "ec2_web" {
  source = "./modules/ec2-web"

  subnet_id         = module.network.web_subnet_id
  security_group_id = module.security.web_security_group_id
  name_prefix       = local.name_prefix
  instance_type     = "t3.micro"
  key_name          = local.key_name
}

# APIサーバーEC2モジュール
# module "ec2_api" {
#   source                    = "./modules/ec2-api"
#   subnet_id                 = module.network.api_subnet_id
#   security_group_id         = module.security.api_security_group_id
#   name_prefix               = local.name_prefix
#   instance_type             = "t3.micro"
#   key_name                  = local.key_name
#   iam_instance_profile_name = module.iam.api_instance_profile_name
# }

# ALBモジュール
module "alb" {
  source = "./modules/alb"

  name_prefix       = local.name_prefix
  vpc_id            = module.network.vpc_id
  subnet_ids        = [module.network.elb_subnet_1_id, module.network.elb_subnet_2_id]
  security_group_id = module.security.elb_security_group_id
  # api_instance_id   = module.ec2_api.instance_id
}

# Auto Scalingモジュール
module "autoscaling" {
  source = "./modules/autoscaling"

  name_prefix               = local.name_prefix
  ami_id                    = "ami-0adeceb9ebe3ac6f7"
  instance_type             = "t3.micro"
  key_name                  = local.key_name
  security_group_id         = module.security.api_security_group_id
  iam_instance_profile_name = module.iam.api_instance_profile_name
  subnet_ids                = [module.network.api_subnet_id]
  target_group_arn          = module.alb.target_group_arn
  min_size                  = 1
  max_size                  = 3
  desired_capacity          = 2
}
