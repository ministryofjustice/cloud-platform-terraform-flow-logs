

locals {
  #if is_enabled is true AND a vpc_id has been provided, then vpc_enabled is true
  vpc_enabled = var.is_enabled ? (var.vpc_id != "" ? 1 : 0) : 0
  subnet_enabled = var.is_enabled ? (var.subnet_id != "" ? 1 : 0) : 0
  eni_enabled = var.is_enabled ? (var.eni_id != "" ? 1 : 0) : 0
}

resource "aws_s3_bucket" "flow_logs" {
  count = var.is_enabled ? 1: 0

  bucket_prefix = "cloud-platform-"
}

resource "aws_s3_bucket_acl" "flow_logs_bucket_acl" {
  count = var.is_enabled ? 1: 0
  
  bucket = aws_s3_bucket.flow_logs[count.index].id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "config" {
  count = var.is_enabled ? 1: 0

  bucket = aws_s3_bucket.flow_logs[count.index].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_flow_log" "vpc_log" {
  count           = local.vpc_enabled

  log_destination_type = "s3"
  log_destination = aws_s3_bucket.flow_logs[count.index].arn
  traffic_type    = var.traffic_type
  vpc_id          = var.vpc_id
  log_format      = var.log_format
}

resource "aws_flow_log" "subnet_log" {
  count           = local.subnet_enabled

  log_destination_type = "s3"
  log_destination = aws_s3_bucket.flow_logs[count.index].arn
  traffic_type    = var.traffic_type
  subnet_id       = var.subnet_id
}


resource "aws_flow_log" "eni_log" {
  count           = local.eni_enabled

  log_destination_type = "s3"
  log_destination = aws_s3_bucket.flow_logs[count.index].arn
  traffic_type    = var.traffic_type
  eni_id          = var.eni_id
}

