
# -----------------------------------------------

# Create an IAM User Group
# resource "aws_iam_group" "cloud_tracker_user_group" {
#   name = "cloud-tracker-user-group"
# }

# Create an IAM User
# resource "aws_iam_user" "cloud_tracker_user" {
#   name = "cloud-tracker-user"
# }

# Add the IAM User to the IAM User Group
# resource "aws_iam_user_group_membership" "cloud_tracker_user_group_membership" {
#   user = aws_iam_user.cloud_tracker_user.name
#   groups = [aws_iam_group.cloud_tracker_user_group.name]
# }

# Define a Policy Document
# resource "aws_iam_policy_document" "cloud_tracker_policy_document" {
#   version = "2012-10-17" # Terraform will choose a sensible option if not defined
#   statement { 
#     actions = ["ec2:*"]
#     effect    = "Allow" # this is optional, if not defined it defaults to Allow
#     resources = ["*"]
#   }
# }

# Create an IAM Policy from the Policy Document
# resource "aws_iam_policy" "cloud_tracker_policy_ec2" {
#   name = "cloud-tracker-policy-ec2"
#   policy = data.aws_iam_policy.cloud-tracker-policy-document.json
# }

# # Attach the IAM Policy to the IAM User Group
# resource "aws_iam_group_policy_attachment" "cloud-tracker-policy-attachment" {
#   policy_arn = aws_iam_policy.cloud_tracker_policy_ec2.arn
#   group = aws_iam_group.cloud_tracker_user_group.name
# }

# -----------------------------------------------

# Create an IAM Role that allows EC2 access
# resource "aws_iam_role" "ec2_access_role" {
#   name = "EC2AccessRole"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Action = "sts:AssumeRole",
#         Effect = "Allow",
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       }
#     ]
#   })
# }

# Create an IAM Instance Profile and associate it with the IAM Role
# resource "aws_iam_instance_profile" "ec2_access_instance_profile" {
#   name = "EC2AccessInstanceProfile"
#   role = aws_iam_role.ec2_access_role.name
# }

# Attach the IAM Policy to the IAM Role
# resource "aws_iam_policy_attachment" "ec2_access_role_policy_attachment" {
#   name       = "EC2AccessRolePolicyAttachment"
#   roles      = [aws_iam_role.ec2_access_role.name]
#   policy_arn = aws_iam_policy.ec2_access_policy.arn
# }

# -----------------------------------------------