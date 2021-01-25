variable "log_destination_type" {
  description = "s3 or cloud-watch-logs"
  default= "s3"
}

variable "vpc_id" {
  description = "VPC ID as flow logs source."
  default     = ""
}

variable "subnet_id" {
  description = "SUBNET ID as flow logs source."
  default     = ""
}

variable "eni_id" {
  description = "ENI ID as flow logs source."
  default     = ""
}


variable "traffic_type" {
  description = "Type of traffic to be logged"
  default = "ALL"
}

variable "is_enabled" {
  description = "switch to enable disable, defaults to false"
  value = "false"
}