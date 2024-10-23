resource "aws_cloudwatch_log_group" "eks_log_group" {
  name              = var.log_group_name  
  retention_in_days = var.retention_in_days #30
}

resource "aws_sns_topic" "alarm_topic" {
    name = var.alarm_topic_name 
}

resource "aws_sns_topic_subscription" "alarm_subscription" {
    topic_arn = aws_sns_topic.alarm_topic.arn
    protocol = var.subscription_protocol 
    endpoint = var.subscription_endpoint 
}

resource "aws_cloudwatch_metric_alarm" "eks_cpu_alarm" {
  alarm_name          = var.alarm_name 
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.evalation_periods #2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EKS"
  period              = var.period 
  statistic           = var.statistic 
  threshold           = var.threshold 

  alarm_actions = [
    aws_sns_topic.alarm_topic.arn
  ]
}