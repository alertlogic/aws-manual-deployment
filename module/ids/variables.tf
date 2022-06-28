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
    af-south-1     = "ami-0b38c9c1f0001b4e0"
    ap-east-1      = "ami-081f77c8b5c8d7b7b"
    ap-northeast-2 = "ami-05e8d42ff766f1a18"
    ap-northeast-1 = "ami-0e76fb23df1073c3c"
    ap-northeast-3 = "ami-077c261e21787ec0d"
    ap-south-1     = "ami-0cff631d5d9a03ca3"
    ap-southeast-1 = "ami-091293dd9427541e8"
    ap-southeast-2 = "ami-0c2daa61e9b78f7e9"
    ca-central-1   = "ami-0a81e16d456ed1456"
    eu-central-1   = "ami-09b2a06d1cf759f5e"
    eu-north-1     = "ami-031ffad2caefc0844"
    eu-south-1     = "ami-02a52690ea0c025ad"
    eu-west-3      = "ami-04a3bab70413865c5"
    eu-west-2      = "ami-000f1229afd52f6c7"
    eu-west-1      = "ami-003b8386b82577f2d"
    me-south-1     = "ami-0bb2a50f0528d21e9"
    sa-east-1      = "ami-05944af019bb51618"
    us-east-1      = "ami-0ad4f867c12b9a2c4"
    us-east-2      = "ami-0c9a7799259dfaea3"
    us-west-1      = "ami-0257398b40304b04e"
    us-west-2      = "ami-08d8f306e694f7db5"
    us-gov-east-1  = "ami-0dcff38a34bbeb408"
    us-gov-west-1  = "ami-03a2250b7c652948a"
  }
}

variable "internal" {
  description = "Internal tags for tracking deployment versions"
  default     = "3.0.0"
}