variable "vpc_id" {
  description = "Specify the VPC ID where the appliance will be deployed in."
}

variable "vpc_cidr" {
  description = "CIDR netblock for the VPC."
}

variable "ci_subnet_id" {
  description = "Specify the existing subnet ID where the Scanning appliance will be deployed in."
}

variable "ci_subnet_type" {
  description = "Select if the subnet is a public or private subnet. Enter Public or Private"
}

variable "ci_instance_type" {
  description = "AlertLogic Security Appliance EC2 instance type."
}

variable "ci_appliance_number" {
  description = "Number of appliances to be deployed set by the Autoscaling group."
  default     = "1"
}