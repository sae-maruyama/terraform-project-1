# Application Load Balancer
resource "aws_lb" "api" {
  name               = "${var.name_prefix}-api-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "${var.name_prefix}-api-alb"
    Type = "ALB"
  }
}

# Target Group
resource "aws_lb_target_group" "api" {
  name     = "${var.name_prefix}-api-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/"
    matcher             = "200"
    port                = "traffic-port"
    protocol            = "HTTP"
  }

  tags = {
    Name = "${var.name_prefix}-api-tg"
  }
}

# # Target Group Attachment（既存ec2-api）
# resource "aws_lb_target_group_attachment" "api" {
#   target_group_arn = aws_lb_target_group.api.arn
#   target_id        = var.api_instance_id
#   port             = 80
# }

# Listener
resource "aws_lb_listener" "api" {
  load_balancer_arn = aws_lb.api.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    forward {
      target_group {
        arn = aws_lb_target_group.api.arn
      }
    }
  }
}
