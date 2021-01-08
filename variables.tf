
variable "log_group_name" {
  description = "Name of Cloudwatch log group"
  default     = "my-flowlog"
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
