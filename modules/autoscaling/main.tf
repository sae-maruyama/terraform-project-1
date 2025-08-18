# Launch Template
resource "aws_launch_template" "api" {
  name_prefix   = "${var.name_prefix}-api-template-"
  description   = "Launch template for API servers"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [var.security_group_id]

  iam_instance_profile {
    name = var.iam_instance_profile_name
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.name_prefix}-api-server-asg"
      Type = "APIServer-AutoScaling"
    }
  }

  # Launch Templateのバージョン管理
  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.name_prefix}-api-launch-template"
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "api" {
  name                      = "${var.name_prefix}-api-asg"
  vpc_zone_identifier       = var.subnet_ids
  target_group_arns         = [var.target_group_arn]
  health_check_type         = "ELB"
  health_check_grace_period = 300

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  launch_template {
    id      = aws_launch_template.api.id
    version = "$Latest"
  }

  # インスタンス更新設定
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
  }

  tag {
    key                 = "Name"
    value               = "${var.name_prefix}-api-asg"
    propagate_at_launch = false
  }

  tag {
    key                 = "Type"
    value               = "AutoScalingGroup"
    propagate_at_launch = false
  }
}

# Auto Scaling Policy - Scale Up
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "${var.name_prefix}-api-scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.api.name
}

# Auto Scaling Policy - Scale Down
# resource "aws_autoscaling_policy" "scale_down" {
#   name                   = "${var.name_prefix}-api-scale-down"
#   scaling_adjustment     = -1
#   adjustment_type        = "ChangeInCapacity"
#   cooldown               = 300
#   autoscaling_group_name = aws_autoscaling_group.api.name
# }

# CloudWatch Alarm - High CPU
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "${var.name_prefix}-api-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "70"
  alarm_description   = "This metric monitors ec2 cpu utilization"
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.api.name
  }

  tags = {
    Name = "${var.name_prefix}-cpu-high-alarm"
  }
}

# CloudWatch Alarm - Low CPU
# resource "aws_cloudwatch_metric_alarm" "cpu_low" {
#   alarm_name          = "${var.name_prefix}-api-cpu-low"
#   comparison_operator = "LessThanThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/EC2"
#   period              = "120"
#   statistic           = "Average"
#   threshold           = "30"
#   alarm_description   = "This metric monitors ec2 cpu utilization"
#   alarm_actions       = [aws_autoscaling_policy.scale_down.arn]

#   dimensions = {
#     AutoScalingGroupName = aws_autoscaling_group.api.name
#   }

#   tags = {
#     Name = "${var.name_prefix}-cpu-low-alarm"
#   }
# }
