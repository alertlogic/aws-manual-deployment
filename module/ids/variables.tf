variable "vpc_id" {
  description = "Specify the VPC ID where the IDS appliance will be deployed in."
}

variable "vpc_cidr" {
  description = "CIDR netblock for the VPC."
}

variable "ids_subnet_id" {
  description = "Specify a list of existing subnet ID's where the IDS appliance(s) will be deployed in."
}

variable "ids_subnet_type" {
  description = "Select if the subnet is a public or private subnet. Enter Public or Private"
}

variable "ids_instance_type" {
  description = "IDS Appliance EC2 instance type."
}

variable "ids_appliance_number" {
  description = "Number of IDS appliances to be deployed set by the Autoscaling group."
  default     = "1"
}