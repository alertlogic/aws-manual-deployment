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
    ap-east-1      = "ami-0a8bff24b3e55224b"
    ap-northeast-1 = "ami-0e9664a9fcbf01220"
    ap-northeast-2 = "ami-0c0adcc9d3bf64cad"
    ap-northeast-3 = "ami-0ede4174a29f36f71"
    ap-south-1     = "ami-0f4fb35dea6c310c1"
    ap-southeast-1 = "ami-07c7a65a21c3ccd58"
    ap-southeast-2 = "ami-0b324b4d4cc6753cb"
    ap-southeast-3 = "ami-02c13c56c0e9d8c99"
    ap-southeast-4 = "ami-095d6d1a718ca6098"
    ca-central-1   = "ami-08c790ee5bad56836"
    eu-central-1   = "ami-01fd7c1b7f4d969b4"
    eu-central-2   = "ami-0c77ad1e182233176"
    eu-north-1     = "ami-06847c2a54fab56cc"
    eu-south-1     = "ami-02e8d8010af7072ac"
    eu-south-2     = "ami-06f2f18633c07ac3d"
    eu-west-1      = "ami-0c5f94fee8ca0e911"
    eu-west-2      = "ami-06d203499484c5431"
    eu-west-3      = "ami-0338227e0ab6ac5d1"
    me-south-1     = "ami-00716048f6f598b95"
    sa-east-1      = "ami-0256e6e7d007627d0"
    us-east-1      = "ami-02e38d2e4fdf655ad"
    us-east-2      = "ami-062df8079ee0fb7f0"
    us-west-1      = "ami-0183a32d7abcc1ec5"
    us-west-2      = "ami-05cb3bacd3020afe6"
    af-south-1     = "ami-0a4979950cb37691e"
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
