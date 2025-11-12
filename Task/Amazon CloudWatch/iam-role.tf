resource "aws_iam_role" "ec2-role" {
    name = "EC2-CloudWatch"

    assume_role_policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
            {
            "Action" : "sts:AssumeRole",
            "Principal":{
                "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
            }
        ]        
    })
    tags = {
      Name = "Ec2-CloudWatch-Role"
    }
}

# Attaching the policy
resource "aws_iam_role_policy_attachment" "cloudwatch_policy" {
    role = aws_iam_role.ec2-role.name
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# Attching the policy for ec2 full access
resource "aws_iam_role_policy_attachment" "ec2-policy" {
    role = aws_iam_role.ec2-role.name
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Create instance profile
resource "aws_iam_instance_profile" "ec2_profile" {
    name = "EC2-CloudWatchh-Profile"
    role = aws_iam_role.ec2-role.name
}