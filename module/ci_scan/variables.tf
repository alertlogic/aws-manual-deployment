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

variable "ci_subnet_ids" {
  description = "Specify the existing subnet ID where the Scanning appliance will be deployed in."
  type        = list(string)
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
    ap-east-1      = "ami-0744826a43ebcaa20"
    ap-northeast-1 = "ami-00f06755223327782"
    ap-northeast-2 = "ami-02914a21d67a3d422"
    ap-south-1     = "ami-01497ed57020df9a1"
    ap-southeast-1 = "ami-06007137c7dad1ef6"
    ap-southeast-2 = "ami-02910709a8a3d1d40"
    ca-central-1   = "ami-06ff0915aea36b0c5"
    eu-central-1   = "ami-075f103b9b7d6c2fe"
    eu-north-1     = "ami-0e60f60be7e206a79"
    eu-west-1      = "ami-0fca75afdd4b43b58"
    eu-west-2      = "ami-0cccfea5d111b17f4"
    eu-west-3      = "ami-0472090cd7e0b2d9e"
    me-south-1     = "ami-0c30caf7cad4a4fcf"
    sa-east-1      = "ami-09f538166c4483f6c"
    us-east-1      = "ami-0b35743e831becad1"
    us-east-2      = "ami-00d46562af87f9209"
    us-west-1      = "ami-02db305d04e11d40b"
    us-west-2      = "ami-01651323b6338e70b"
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