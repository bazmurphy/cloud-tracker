# -----------------------------------------------

# Create a Launch Template
resource "aws_launch_template" "cloud_tracker_launch_template" {
  # [1] Launch Template Name And Description
  # [1.1] Launch Template Name
  name = "cloud-tracker-launch-template"
  # [1.2] Template Version Description
  description = "Cloud Tracker Launch Template"

  # [2] Application and OS Images (Amazon Machine Image)
  image_id = data.aws_ami.cloud_tracker_ec2_instance_ami.id

  # [3] Instance Type
  instance_type = "t2.micro"

  # [4] Key Pair Login
  # key_name = ""

  # [5] Network Settings
  # [5.1]
  # Subnet
  # [5.2]
  # Firewall (Security Groups)
  # vpc_security_group_ids = [aws_security_group.cloud_tracker_security_group_ec2_instance.id]

  # A list of security group names to associate with,
  # If you are creating Instances in a VPC, use vpc_security_group_ids instead
  # security_group_names = [aws_security_group.cloud_tracker_security_group_ec2_instance.id]


  # Attaches one or more Network Interfaces to the instance.
  network_interfaces {
    # Associate a public ip address with the network interface
    associate_public_ip_address = true
    # A list of security group IDs to associate
    security_groups = [aws_security_group.cloud_tracker_security_group_ec2_instance.id]
    # The VPC Subnet ID to associate
    # subnet_id = aws_subnet.cloud_tracker_subnet_public_one.id
  }

  # [6] Storage (Volumes)
  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 8
      volume_type           = "gp3"
      iops                  = 3000
      delete_on_termination = true
      encrypted             = false
      throughput            = 125
    }
  }

  # [7] Resource Tags
  tag_specifications {
    resource_type = "instance"
    tags = {
      "Name" = "cloud-tracker-launch-template-instance"
    }
  }

  # [8] Advanced Details
  # [8.1] IAM Instance Profile
  # I should add this...

  # [8.3] DNS Hostname
  # private_dns_name_options {
  # Enable resource-based IPv4 (A record) DNS requests
  # enable_resource_name_dns_a_record = true
  # Enable resource-based IPv6 (AAAA record) DNS requests
  # enable_resource_name_dns_aaaa_record = true
  # }

  # [8.10] Detailed CloudWatch Monitoring
  monitoring {
    enabled = true
  }

  # [8.26] User Data
  # user_data = filebase64("${path.module}/example.sh")
  user_data = filebase64("ec2-user-data-lb-test.sh")

  tags = {
    "Name" = "cloud-tracker-launch-template"
  }
}

# -----------------------------------------------

# Create an Auto Scaling Group
resource "aws_autoscaling_group" "cloud_tracker_autoscaling_group" {
  # [1] Auto Scaling Group Name
  name = "cloud-tracker-autoscaling-group"

  # [2] Launch Template
  launch_template {
    id      = aws_launch_template.cloud_tracker_launch_template.id
    version = "$Latest"
  }

  # [3] Instance Type Requirements
  # ???

  # [4] Network
  # [4.1] VPC
  # [4.2] Availability Zones And Subnets
  # availability_zones  = [""]
  vpc_zone_identifier = [aws_subnet.cloud_tracker_subnet_public_one.id, aws_subnet.cloud_tracker_subnet_public_two.id]

  # [5] Load Balancing
  # [5.1] Attach to an Existing Load Balancer
  target_group_arns = [aws_lb_target_group.cloud_tracker_load_balancer_target_group.arn]

  # [6] VPC Lattice Integration Options
  # ???

  # [7] Health Checks
  # [7.1] EC2 Health Checkes Always Enabled
  # [7.2] Elastic Load Balancing Health Checks
  health_check_type = "ELB"
  # [7.3] Health Check Grace Period
  health_check_grace_period = 300

  # [8] Monitoring
  # [8.1] Enable Group Metrics Collection within Cloudwatch
  # enabled_metrics = [ ??? ]
  # [8.2] Enable Default Instance Warmup
  # default_instance_warmup = false

  # [9] Group Size
  desired_capacity = 1
  min_size         = 1
  max_size         = 2

  # [10] Scaling Policies
  # [10.1] Scaling Policy Name
  # target-tracking-scaling-policy-name
  # [10.2] Metric Type
  # Average CPU Utilization
  # [10.3] Target Value
  # 50 %
  # [10.4] Instance Warmup
  # 300 Seconds

  # [11] Enable Instance Scale-In Protection
  # protect_from_scale_in = ???

  # [12] Add Notification
  # ???

  # [13] Add Tags
  tag {
    key                 = "Name"
    value               = "cloud-tracker-autoscaling-group-instance"
    propagate_at_launch = true
  }
}

# -----------------------------------------------

# Both approaches (target_group_arns or aws_autoscaling_attachment) will attach the ASG to the ALB target group. 
# The attachment resource just provides a more explicit way to define the connection as a separate resource.

# # Attach the Auto Scaling Group to the Load Balancer Target Group
# resource "aws_autoscaling_attachment" "cloud_tracker_autoscaling_attachment" {
#   autoscaling_group_name = aws_autoscaling_group.cloud_tracker_autoscaling_group.id
#   lb_target_group_arn    = aws_lb_target_group.cloud_tracker_load_balancer_target_group.arn
# }

# -----------------------------------------------
