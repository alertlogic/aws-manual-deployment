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
    af-south-1     = "ami-05f5f82a73ff45b11"
    ap-east-1      = "ami-0108990e176bcc46a"
    ap-northeast-2 = "ami-0416ce87b5c3251cb"
    ap-northeast-1 = "ami-02a38f262bef42fbb"
    ap-south-1     = "ami-00fea52fb02d7a158"
    ap-southeast-1 = "ami-065080b026b96dbbf"
    ap-southeast-2 = "ami-04e83a130038b4162"
    ca-central-1   = "ami-03425de77706f2451"
    eu-central-1   = "ami-069bcb10e420963e2"
    eu-north-1     = "ami-02e1060567ea6751a"
    eu-south-1     = "ami-0de0afe5e9e14dd7a"
    eu-west-3      = "ami-0e88b6530c8dfc7a5"
    eu-west-2      = "ami-001dae8374cdea97e"
    eu-west-1      = "ami-0af1970a486c17636"
    me-south-1     = "ami-0df563b310715fd35"
    sa-east-1      = "ami-0788ced3eefd3829c"
    us-east-1      = "ami-0123a7ce575cf7828"
    us-east-2      = "ami-0a1f3c41aa6202b46"
    us-west-1      = "ami-0ff56e02e16b4d5ec"
    us-west-2      = "ami-0b2b60d06fb352cf0"
    us-gov-east-1  = "ami-002018a49c13a6e21"
    us-gov-west-1  = "ami-0f9925f59f6b2a2e7"
  }
}

variable "internal" {
  description = "Internal tags for tracking deployment versions"
  default     = "3.0.0"
}