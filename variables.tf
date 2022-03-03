variable "account_id" {
  description = "Your AlertLogic Account ID"
  type        = string
}

variable "deployment_id" {
  description = "Your AlertLogic Deployment ID"
  type        = string
}

variable "stack" {
  description = "AlertLogic DataCenter where the appliance will be deployed in. Enter US or UK"
  type        = string
}

variable "create_ids" {
  description = <<-EOT
    Set value to true to include IDS coverage for the "Professional" protection subscription tier, otherwise set to false if your scope of protection set to "Essentials/Scanning" only, IDS will not be deployed
EOT
  type        = bool
}

variable "vpc_id" {
  description = "Specify the VPC ID where the appliance will be deployed in"
  type        = string

}

variable "vpc_cidr" {
  description = "Specify the VPC CIDR block"
  type        = string
}

variable "ci_subnet_ids" {
  description = "Specify the existing subnet ID where the Scanning appliance will be deployed in"
  type        = list(string)
}

variable "ci_subnet_type" {
  description = "Select if the subnet is a public or private subnet. Enter Public or Private"
  type        = string
  default     = "Public"
}

variable "ci_instance_type" {
  description = <<-EOT
    AlertLogic Security Appliance EC2 instance type. Enter m4.large, m4.xlarge, m4.2xlarge, m5.large, m5.xlarge, m5.2xlarge, c4.large, c4.xlarge, c4.2xlarge, c5.large, c5.xlarge or c5.2xlarge
EOT
  type        = string
  default     = "c5.large"
}

variable "ci_appliance_number" {
  description = "Number of Security appliances to be deployed set by the Autoscaling group"
  type        = number
  default     = 1
}

variable "ids_instance_type" {
  description = <<-EOT
    AlertLogic IDS Appliance EC2 instance type. Enter m4.large, m4.xlarge, m4.2xlarge, m5.large, m5.xlarge, m5.2xlarge, c4.large, c4.xlarge, c4.2xlarge, c5.large, c5.xlarge or c5.2xlarge
EOT
  type        = string
  default     = "c5.xlarge"
}

variable "ids_appliance_number" {
  description = "Number of IDS appliances to be deployed set by the Autoscaling group"
  type        = number
  default     = 1
}

variable "ids_subnet_ids" {
  description = "List of subnet ID(s) where the IDS appliances will be deployed in"
  type        = list(string)
}

variable "ids_subnet_type" {
  description = "Select if the subnet is a public or private subnet. Enter Public or Private"
  type        = string
}
