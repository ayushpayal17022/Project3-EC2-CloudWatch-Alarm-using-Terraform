provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "monitor_ec2" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"

  key_name = "project15-key"

  tags = {
    Name = "CloudWatch-Monitoring-Server"
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "High-CPU-Alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 20

  dimensions = {
    InstanceId = aws_instance.monitor_ec2.id
  }

  alarm_description = "Alarm when EC2 CPU exceeds 20%"
}

