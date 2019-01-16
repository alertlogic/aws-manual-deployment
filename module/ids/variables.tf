variable "account_id" {
  description = "AlertLogic Account ID."
}

variable "deployment_id" {
  description = "AlertLogic cloudinsight Deployment ID."
}

variable "vpc_id" {
  description = "Specify the VPC ID where the appliance will be deployed in."
}

variable "subnet_id" {
  description = "Specify the existing subnet ID where the appliance will be deployed in."
}

variable "subnet_type" {
  description = "Select if the subnet is a public or private subnet. Enter Public or Private"
}

variable "vpc_cidr" {
	description = "CIDR netblock of the VPC to be monitored (Where agents will be installed)."
  type = "string"
}

variable "availability_zones" {
  description = "Select target AZ matching selected subnet ID."
}

variable "ids_instance_type" {
  description = "AlertLogic Security Appliance EC2 instance type. Enter m3.medium, m3.large, m3.xlarge or m3.2xlarge"
  default = "m3.medium"
}

variable "ids_appliance_number" {
  description = "Number of appliances to be deployed set by the Autoscaling group."
}

variable "create_ids" {
  description = "Set value to 1(true) to include IDS coverage for the Professional protection subscription tier, otherwise set to 0(false) if your scope of protection set to Essentials/Scanning only, IDS will not be deployed."
}

// the latest AMI is provided by Alert Logic and should have been previously shared with the AWS account deploying the IDS security appliance
variable "aws_amis" {
  type    = "map"
  default =  {
    ap-south-1 = "ami-944916fb"
		eu-west-3 = "ami-2d66d050"
		eu-west-2 = "ami-c66480a1"
		eu-west-1 = "ami-c57336bc"
		ap-northeast-2 = "ami-e768c589"
		ap-northeast-1 = "ami-f07e3896"
		sa-east-1 = "ami-72115a1e"
		ca-central-1 = "ami-6d880f09"
		ap-southeast-1 = "ami-1c1e5560"
		ap-southeast-2 = "ami-3edd1b5c"
		eu-central-1 = "ami-aa92ffc5"
		us-east-1 = "ami-5934df24"
		us-east-2 = "ami-e5fdca80"
		us-west-1 = "ami-87e6ede7"
		us-west-2 = "ami-5b9e1623"
		us-gov-west-1 = "ami-89df5ce8"
  }
}

variable "stack_vaporator" {
  type    = "map"
  default = {
    US.host = "agentapi.cloudinsight.alertlogic.com"
    US.port = "443"
    UK.host = "agentapi.cloudinsight.alertlogic.co.uk"
    UK.port = "443"
  }
}

variable "internal" {
  description = "Internal tags for tracking deployment versions"
  default = "1.0.0"
}
