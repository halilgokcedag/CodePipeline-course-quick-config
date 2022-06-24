resource "aws_iam_instance_profile" "aws-codeDeploy-ec2-profile" {
  name = "aws-codeDeploy-ec2-role"
  role = aws_iam_role.aws-codeDeploy-ec2-role.name
}

resource "aws_iam_role" "aws-codeDeploy-ec2-role" {
  name = "aws-codeDeploy-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}
resource "aws_iam_role_policy_attachment" "AWSElasticBeanstalkWebTier" {
  role       = aws_iam_role.aws-codeDeploy-ec2-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
}


resource "aws_iam_role" "codeDeploy_service_role" {
  name               = "aws-codeDeploy-service-role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "codedeploy.amazonaws.com"
                ]
            },
            "Action": [
                "sts:AssumeRole"
            ]
        }
    ]
}
EOF
}


resource "aws_iam_role_policy_attachment" "AWSElasticBeanstalkEnhancedHealth" {
  role       = aws_iam_role.codeDeploy_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}

