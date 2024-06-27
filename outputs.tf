output "s3_bucket_arn" {
  description = "s3 bucket arn"
  value = var.is_enabled ? aws_s3_bucket.flow_logs[0].arn : null
}

output "s3_bucket_id" {
  description = "s3 bucket id"
  value = var.is_enabled ? aws_s3_bucket.flow_logs[0].id : null
}