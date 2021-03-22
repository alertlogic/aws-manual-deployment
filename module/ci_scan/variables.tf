variable "account_id" {
  description = "AlertLogic Account ID."
}

variable "deployment_id" {
  description = "AlertLogic cloudinsight Deployment ID."
}

variable "stack" {
  description = "AlertLogic DataCenter where the appliance will be deployed in. Enter US or UK"
  default     = "US"
}

variable "vpc_id" {
  description = "Specify the VPC ID where the appliance will be deployed in."
}

variable "ci_subnet_id" {
  description = "Specify the existing subnet ID where the Scanning appliance will be deployed in."
}

variable "ci_subnet_type" {
  description = "Select if the subnet is a public or private subnet. Enter Public or Private"
}

variable "vpc_cidr" {
  description = "CIDR netblock for the VPC."
  type        = "string"
}

variable "ci_instance_type" {
  description = "AlertLogic Security Appliance EC2 instance type. Enter m3.medium, m3.large, m3.xlarge or m3.2xlarge"
  default     = "m3.medium"
}

variable "ci_appliance_number" {
  description = "Number of appliances to be deployed set by the Autoscaling group."
  default     = "1"
}

// the latest AMI is provided by Alert Logic and should have been previously shared with the AWS account deploying the security appliance
variable "aws_amis" {
  type = "map"

  default = {
      ap-east-1       = "ami-00b1e2df7e6f55bdc"
      ap-northeast-2  = "ami-07185b9ff1dc384b8"
      ap-northeast-1  = "ami-0c51e0eeb89ea57cb"
      ap-south-1      = "ami-07dde1f863928032c"
      ap-southeast-1  = "ami-076affc300b3f974f"
      ap-southeast-2  = "ami-0892d934fbc643585"
      ca-central-1    = "ami-088e7a0aa3de642de"
      sa-east-1       = "ami-05099c9a953304422"
      eu-central-1    = "ami-0075a34755064f92b"
      eu-north-1      = "ami-0d065c2312363c2e4"
      eu-west-1       = "ami-06614b5b2bea68751"
      eu-west-2       = "ami-0f37f0a12298d59c6"
      eu-west-3       = "ami-073077d0478138645"
      me-south-1      = "ami-0a12b886c69fbf4ca"
      us-east-1       = "ami-0cfe1e2d48132cb1f"
      us-east-2       = "ami-0a0bfd0683191baa7"
      us-west-1       = "ami-0182f258247fc032c"
      us-west-2       = "ami-05b6c462cc60392b9"
  }
}

variable "stack_vaporator" {
  type = "map"

  default = {
    US.host = "agentapi.cloudinsight.alertlogic.com"
    US.port = "443"
    UK.host = "agentapi.cloudinsight.alertlogic.co.uk"
    UK.port = "443"
  }
}

variable "internal" {
  description = "Internal tags for tracking deployment versions"
  default     = "1.0.0"
}
