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
  description = "switch to enable/disable the module, defaults to false"
  default = false
}

variable "log_format" {
  description = "Fields to include in the flow log record"
  default = "$${version} $${account-id} $${interface-id} $${srcaddr} $${dstaddr} $${srcport} $${dstport} $${protocol} $${packets} $${bytes} $${start} $${end} $${action} $${log-status} $${az-id} $${flow-direction} $${instance-id} $${pkt-srcaddr} $${pkt-dstaddr} $${region} $${sublocation-id} $${sublocation-type} $${subnet-id} $${tcp-flags} $${type} $${vpc-id}"
}