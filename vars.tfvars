/*
# -------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# -------------------------------------------------------------------------------------------------------------------
*/
#aws_assumed_role_arn = "arn:aws:iam::<aws_account>:role/<assumed_role>" // This field is only necessary when an assumed role is required. Commented out by default.

aws_profile = "aws_profile" // The AWS profile configured for credentials OR matching AWS_PROFILE environment variable

aws_cred_file = "~/.aws/credentials" // An AWS credentials file to specify your credentials

aws_region = "xx-xxxx-x" // The AWS region to deploy the appliance in

vpc_id = "vpc-xxxx" // Specify the VPC ID where the appliance will be deployed in

vpc_cidr = "x.x.x.x/x" // Specify the VPC CIDR block

ci_subnet_id = "subnet-xxxx" // Specify the existing subnet ID where the Scanning appliance will be deployed in

ci_subnet_type = "Public" // Select if the subnet is a public or private subnet. Enter Public or Private

ci_instance_type = "c5.large" // AlertLogic Security Appliance EC2 instance type. Enter m4.large, m4.xlarge, m4.2xlarge, m5.large, m5.xlarge, m5.2xlarge, c4.large, c4.xlarge, c4.2xlarge, c5.large, c5.xlarge or c5.2xlarge

ci_appliance_number = "1" // Number of Secuirty appliances to be deployed set by the Autoscaling group

ids_subnet_id = "subnet-xxxx" // List of subnet ID(s) where the IDS appliances will be deployed in

ids_subnet_type = "Public" // Select if the subnet is a public or private subnet. Enter Public or Private

ids_instance_type = "c5.xlarge" // AlertLogic IDS Appliance EC2 instance type. Enter m4.large, m4.xlarge, m4.2xlarge, m5.large, m5.xlarge, m5.2xlarge, c4.large, c4.xlarge, c4.2xlarge, c5.large, c5.xlarge or c5.2xlarge

ids_appliance_number = "1" // Number of IDS appliances to be deployed set by the Autoscaling group
