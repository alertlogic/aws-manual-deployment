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
    ap-south-1     = "ami-0879c22e5418dea4d"
    eu-west-3      = "ami-0d8d14f03858564b6"
    eu-west-2      = "ami-0bce0c3bff2dfabca"
    eu-west-1      = "ami-022bbea7941d3b76c"
    ap-northeast-2 = "ami-01876844d308d37b8"
    ap-northeast-1 = "ami-0195eb55461502c40"
    sa-east-1      = "ami-0e3a20cfd0f6e0a7e"
    ca-central-1   = "ami-0e4e7193272369209"
    ap-southeast-1 = "ami-0774a8ece9fd5d040"
    ap-southeast-2 = "ami-086f50ef95eeb7a1e"
    eu-central-1   = "ami-0fa4d2494c3968dbd"
    us-east-1      = "ami-04601abc9f7bc60f1"
    us-east-2      = "ami-00caed404d81d296b"
    us-west-1      = "ami-081668ed8d87b786f"
    us-west-2      = "ami-08df822b4f3206517"
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
