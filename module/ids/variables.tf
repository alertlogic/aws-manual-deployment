variable "account_id" {
  description = "AlertLogic Account ID."
}

variable "deployment_id" {
  description = "AlertLogic cloudinsight Deployment ID."
}

variable "vpc_id" {
  description = "Specify the VPC ID where the appliance will be deployed in."
}

variable "ids_subnet_id" {
  description = "Specify the existing subnet ID(s) where the appliance will be deployed in."
  type        = list(string)
}

variable "ids_subnet_type" {
  description = "Select if the subnet is a public or private subnet. Enter Public or Private"
}

variable "vpc_cidr" {
  description = "CIDR netblock of the VPC to be monitored (Where agents will be installed)."
  type        = string
}

variable "ids_instance_type" {
  description = "AlertLogic Security Appliance EC2 instance type. Enter m3.medium, m3.large, m3.xlarge or m3.2xlarge"
  default     = "m3.medium"
}

variable "ids_appliance_number" {
  description = "Number of appliances to be deployed set by the Autoscaling group."
}

variable "create_ids" {
  description = "Set value to 1(true) to include IDS coverage for the Professional protection subscription tier, otherwise set to 0(false) if your scope of protection set to Essentials/Scanning only, IDS will not be deployed."
}

// the latest AMI is provided by Alert Logic and should have been previously shared with the AWS account deploying the IDS security appliance
variable "aws_amis" {
  type = map(string)

  default = {
    af-south-1     = "ami-09d8ae18fd9476943"
    ap-east-1      = "ami-0b9f781c078c2bb96"
    ap-northeast-2 = "ami-06ba7f4d7cb1a40b0"
    ap-northeast-1 = "ami-02f58faca668c94be"
    ap-northeast-3 = "ami-0d2d1c31f99770410"
    ap-south-1     = "ami-0f0f2c10573854e73"
    ap-southeast-1 = "ami-0feddb0c6dffb4dbb"
    ap-southeast-2 = "ami-059b5f8e11db86595"
    ap-southeast-3 = "ami-04ace3ec9879885eb"
    ap-southeast-4 = "ami-0a72d224fe13ece7e"
    ca-central-1   = "ami-0f47133df1300b88a"
    eu-central-1   = "ami-0a337de49c7e8caab"
    eu-central-2   = "ami-083639a5df843922a"
    eu-north-1     = "ami-079e7eb0df4f17a2f"
    eu-south-1     = "ami-0fa3392bec43a2749"
    eu-south-2     = "ami-00a8cdc73359f9dc5"
    eu-west-3      = "ami-0f9bc8db76f626c3e"
    eu-west-2      = "ami-0f0d8db0584b81dc9"
    eu-west-1      = "ami-07dada231e617e70e"
    me-south-1     = "ami-0a03a45f8665c8642"
    sa-east-1      = "ami-0b5c9b59460471297"
    us-east-1      = "ami-06e37f930d7212ff4"
    us-east-2      = "ami-02817266095676d85"
    us-west-1      = "ami-005b03cb4a5de6210"
    us-west-2      = "ami-02aefdaa7e0441957"
    us-gov-east-1  = "ami-0f9c81dc1da6c15d7"
    us-gov-west-1  = "ami-0a03d3558bc0f1778"
  }
}

variable "internal" {
  description = "Internal tags for tracking deployment versions"
  default     = "3.0.0"
}