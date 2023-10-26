# # -----------------------------------------------

# resource "aws_cloudwatch_metric_alarm" "cloud_tracker_metric_alarm_ec2_cpu_utilization" {
#   # Name of the alarm
#   alarm_name = "cpu-utilization-alarm"
#   #  Sets how the threshold is compared, trigger when greater than
#   comparison_operator = "GreaterThanThreshold"
#   # How many periods to evaluate, 1 period is the last 60 seconds
#   evaluation_periods = "1"
#   # The name of the metric to monitor, CPUUtilization
#   metric_name = "CPUUtilization"
#   # Namespace of the CloudWatch metric. For EC2 metrics its AWS/EC2
#   namespace = "AWS/EC2"
#   # Time Period to evaluate the metric over, 60 seconds
#   period = "60"
#   # What type of statistic to check, we want the Average
#   statistic = "Average"
#   # The value to trigger the alarm at, 80%
#   threshold = "80"

#   # Dimensions to identify the resource being monitored, We link it to the EC2 AutoScaling Group.
#   dimensions = {
#     AutoScalingGroupName = aws_autoscaling_group.cloud_tracker_autoscaling_group.name
#   }

#   #  List of SNS topics to notify when alarm triggers
#   alarm_actions = [aws_sns_topic.cloud_tracker_metric_alarm_ec2_cpu_utilization_sns.arn]
# }

# resource "aws_sns_topic" "cloud_tracker_metric_alarm_ec2_cpu_utilization_sns" {
#   name = "cpu-utilization-alarm"
# }

# # -----------------------------------------------

# resource "aws_cloudwatch_metric_alarm" "cloud_tracker_metric_alarm_rds_read_write" {
#   # Name of the alarm
#   alarm_name = "rds-read-write-alarm"
#   #  Sets how the threshold is compared, trigger when greater than or equal to
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   # How many periods to evaluate, 1 period is the last 60 seconds
#   evaluation_periods = "1"
#   # The name of the metric to monitor, ReadIOPS
#   metric_name = "ReadIOPS"
#   # Namespace of the CloudWatch metric. For RDS metrics its AWS/RDS
#   namespace = "AWS/RDS"
#   # Time Period to evaluate the metric over, 300 seconds
#   period = "300"
#   # What type of statistic to check, we want the Average
#   statistic = "Average"
#   # Threshold value to trigger the alarm. 100 Read IOPS.
#   threshold = "100"

#   # Dimensions to identify the resource being monitored, We link it to the RDS instance
#   dimensions = {
#     DBInstanceIdentifier = aws_db_instance.cloud_tracker_rds_database.id
#   }

#   # List of actions (Notify an SNS topic) to take when alarm is triggered
#   alarm_actions = [aws_sns_topic.cloud_tracker_metric_alarm_rds_read_write_sns.arn]
# }

# resource "aws_sns_topic" "cloud_tracker_metric_alarm_rds_read_write_sns" {
#   name = "rds-alarms"
# }

# # -----------------------------------------------

# resource "aws_cloudwatch_dashboard" "cloud_tracker_cloudwatch_dashboard" {
#   dashboard_name = "cloud-tracker-cloudwatch-dashboard"
#   dashboard_body = jsonencode({
#     "widgets" : [
#       # {
#       #   "type" : "metric",
#       #   "x" : 0,
#       #   "y" : 0,
#       #   "width" : 12,
#       #   "height" : 6,
#       #   "properties" : {
#       #     "metrics" : [
#       #       ["AWS/EC2", "CPUUtilization", "InstanceId", "<ec2_instance_id>"]
#       #     ],
#       #     "period" : 300,
#       #     "stat" : "Average",
#       #     "region" : "eu-west-2",
#       #     "title" : "EC2 CPU"
#       #   }
#       # },
#       {
#         "type" : "metric",
#         "x" : 0,
#         "y" : 6,
#         "width" : 12,
#         "height" : 6,
#         "properties" : {
#           "metrics" : [
#             ["AWS/AutoScaling", "GroupTotalInstances", "AutoScalingGroupName", "${aws_autoscaling_group.cloud_tracker_autoscaling_group.name}"]
#           ],
#           "period" : 300,
#           "stat" : "Average",
#           "region" : "eu-west-2",
#           "title" : "ASG Size"
#         }
#       },
#       {
#         "type" : "metric",
#         "x" : 0,
#         "y" : 12,
#         "width" : 12,
#         "height" : 6,
#         "properties" : {
#           "metrics" : [
#             ["AWS/RDS", "ReadIOPS", "DBInstanceIdentifier", "${aws_db_instance.cloud_tracker_rds_database.id}"]
#           ],
#           "period" : 300,
#           "stat" : "Average",
#           "region" : "eu-west-2",
#           "title" : "RDS Read IOPS"
#         }
#       }
#     ]
#   })
# }

# # -----------------------------------------------
