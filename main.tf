resource "random_id" "flow_logs" {
  byte_length = 8
}

locals {
    name = format("%s-%d", "cloud-platform", random_id.flow_logs.dec)
}

resource "aws_s3_bucket" "flow_logs" {
  bucket = local.name
  acl    = "private"
}


resource "aws_s3_bucket_public_access_block" "config" {
  bucket = aws_s3_bucket.flow_logs.id
  
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_flow_log" "vpc_log" {
  count           = var.vpc_id != "" ? 1 : 0
  log_destination_type = "s3"
  log_destination = aws_s3_bucket.flow_logs.arn
  traffic_type    = var.traffic_type
  vpc_id          = var.vpc_id
}

resource "aws_flow_log" "subnet_log" {
  count           = var.subnet_id != "" ? 1 : 0
  log_destination_type = "s3"
  log_destination = aws_s3_bucket.flow_logs.arn
  traffic_type    = var.traffic_type
  subnet_id       = var.subnet_id
}


resource "aws_flow_log" "eni_log" {
  count           = var.eni_id != "" ? 1 : 0
  log_destination_type = "s3"
  log_destination = aws_s3_bucket.flow_logs.arn
  traffic_type    = var.traffic_type
  eni_id          = var.eni_id
}
