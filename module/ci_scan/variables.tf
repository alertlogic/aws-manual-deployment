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
    ap-south-1     = "ami-92b996fd"
    eu-west-3      = "ami-555dec28"
    eu-west-2      = "ami-9505e9f2"
    eu-west-1      = "ami-05764c7c"
    ap-northeast-2 = "ami-9fbe15f1"
    ap-northeast-1 = "ami-e951a996"
    sa-east-1      = "ami-e5e4ba89"
    ca-central-1   = "ami-40e46724"
    ap-southeast-1 = "ami-f986b985"
    ap-southeast-2 = "ami-eb8f5d89"
    eu-central-1   = "ami-a54b7e4e"
    us-east-1      = "ami-08076977"
    us-east-2      = "ami-96704ff3"
    us-west-1      = "ami-d08e95b0"
    us-west-2      = "ami-928ef5ea"
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
