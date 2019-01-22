/*
# -------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# -------------------------------------------------------------------------------------------------------------------
*/

aws_profile = "aws_profile" // The AWS profile configured for credentials OR matching AWS_PROFILE environment variable
aws_cred_file = "~/.aws/credentials" // An AWS credentials file to specify your credentials
aws_region = "xx-xxxx-x" // The AWS region to deploy the appliance in
account_id = "123456" // Your AlertLogic Account ID
deployment_id = "xxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxxx" // Your AlertLogic cloudinsight Deployment ID
stack = "US" // AlertLogic DataCenter where the appliance will be deployed in. Enter US or UK
create_ids = "1" // Set value to 1(true) to include IDS coverage for the "Professional" protection subscription tier, otherwise set to 0(false) if your scope of protection set to "Essentials/Scanning" only, IDS will not be deployed
vpc_id = "vpc-xxxxxxxx" // Specify the VPC ID where the appliance will be deployed in
vpc_cidr = "10.10.0.0/16" // Specify the VPC CIDR block
subnet_id = "subnet-xxxxxxxx" // Specify the existing subnet ID where the appliance will be deployed in
availability_zones = "us-east-1a,us-east-1b,us-east-1c" // List of availability zone(s) where the IDS appliances will be deployed in
subnet_type = "Public" // Select if the subnet is a public or private subnet. Enter Public or Private
ci_instance_type = "c5.large" // AlertLogic Security Appliance EC2 instance type. Enter m4.large, m4.xlarge, m4.2xlarge, m5.large, m5.xlarge, m5.2xlarge, c4.large, c4.xlarge, c4.2xlarge, c5.large, c5.xlarge or c5.2xlarge
ci_appliance_number = "1" // Number of Secuirty appliances to be deployed set by the Autoscaling group
ids_instance_type = "c5.xlarge" // AlertLogic IDS Appliance EC2 instance type. Enter m4.large, m4.xlarge, m4.2xlarge, m5.large, m5.xlarge, m5.2xlarge, c4.large, c4.xlarge, c4.2xlarge, c5.large, c5.xlarge or c5.2xlarge
ids_appliance_number = "1" // Number of IDS appliances to be deployed set by the Autoscaling group
