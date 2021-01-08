resource "random_id" "flow_logs" {
  byte_length = 8
}

locals {
    name = var.log_group_name!="" ? var.log_group_name : format("%s-%d", "cloud-platform", random_id.flow_logs.dec)
}

resource "aws_cloudwatch_log_group" "flow_logs" {
  name = local.name
}

resource "aws_flow_log" "vpc_log" {
  count           = var.vpc_id != "" ? 1 : 0
  iam_role_arn    = aws_iam_role.flow_logs_role.arn
  log_destination = aws_cloudwatch_log_group.flow_logs.arn
  traffic_type    = var.traffic_type
  vpc_id          = var.vpc_id
}

resource "aws_flow_log" "subnet_log" {
  count           = var.subnet_id != "" ? 1 : 0
  iam_role_arn    = aws_iam_role.flow_logs_role.arn
  log_destination = aws_cloudwatch_log_group.flow_logs.arn
  traffic_type    = var.traffic_type
  subnet_id       = var.subnet_id
}


resource "aws_flow_log" "eni_log" {
  count           = var.eni_id != "" ? 1 : 0
  iam_role_arn    = aws_iam_role.flow_logs_role.arn
  log_destination = aws_cloudwatch_log_group.flow_logs.arn
  traffic_type    = var.traffic_type
  eni_id          = var.eni_id
}


resource "aws_iam_role" "flow_logs_role" {
  name = "local.name"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "flow_logs_policy" {
  name = "local.name"
  role = aws_iam_role.flow_logs_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}