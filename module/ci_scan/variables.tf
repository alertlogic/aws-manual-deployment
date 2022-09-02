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
  type        = string
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
  type = map(string)

  default = {
    ap-east-1       = "ami-00491099c15632859"
    ap-northeast-1  = "ami-00e5e1236a0190e66"
    ap-northeast-2  = "ami-03fc3c943a0fcf4eb"
    ap-northeast-3  = "ami-06ca9da8de3492fb6"
    ap-south-1      = "ami-02bd0ec08a2c29899"
    ap-east-1       = "ami-00491099c15632859"
    ap-southeast-1  = "ami-0e8e751b535af705a"
    ap-southeast-2  = "ami-01177067d2dd75c05"
    ca-central-1    = "ami-0a26524cdfecbd852"
    eu-central-1    = "ami-0e1825c8e35ce6d81"
    eu-north-1      = "ami-0d6a305ce9082582c"
    eu-south-1      = "ami-0701940c7f77f67e9"
    eu-west-1       = "ami-0574ab19b7a2ba70a"
    eu-west-2       = "ami-0279cfea84cb2b524"
    eu-west-3       = "ami-0cdb23dcb2e6ed9c6"
    me-south-1      = "ami-00b5e759c3493e271"
    sa-east-1       = "ami-0934de1d8021e00c3"
    us-east-1       = "ami-063fb3ea2393804df"
    us-east-2       = "ami-04ddd5c786bd4376e"
    us-west-1       = "ami-09526826ceeda44ef"
    us-west-2       = "ami-0c11c7c5f75a8d724"
    af-south-1      = "ami-0159f0cdf073852b7"
  }
}

variable "stack_vaporator" {
  type = map(string)

  default = {
    "US.host" = "agentapi.cloudinsight.alertlogic.com"
    "US.port" = "443"
    "UK.host" = "agentapi.cloudinsight.alertlogic.co.uk"
    "UK.port" = "443"
  }
}

variable "internal" {
  description = "Internal tags for tracking deployment versions"
  default     = "3.0.0"
}