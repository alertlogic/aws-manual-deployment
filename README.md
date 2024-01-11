# Terraform for Manual Mode Deployments in AWS

Collection of Terraform modules to manually deploy Vulnerability Scanning and IDS appliances into an existing customer managed subnet in AWS.

- [Overview](#overview)
- [Use Case: Customer provided subnet](#use-case-customer-provided-subnet)
- [How to Use](#how-to-use)
- [Appendix A](#appendix-a-resource-properties)

## Overview

This template is intended to be used by the customer when `manual` deployment mode is selected for `Deployment Mode`.

The template included here will take care of the creation of the whole infrastructure required to create a working IDS appliance and vulnerability scanning. However, further steps are required to have a fully functional appliance.

## Use Case: Customer provided subnet

In this use case, the customer provides an existing subnet where the appliances are going to be deployed in.

**NOTE**: It is the customer's responsibility to properly configure network access to the chosen subnet. This includes management of IGW, Routes, NACLs and NAT associated with the existing subnet. Scan and IDS appliances must be able to communicate with our Datacenters via IGW or NAT Gateway/NAT instance.

### Requirements

In order to deploy the appliances these requirements must be done prior:

- A `manual` mode AWS deployment exist in the Alert Logic console
- `manual` mode deployments needs to have scope set to at least one VPC
- AWS VPC ID and CIDR where the appliances will be deployed in
- Subnet ID and type (public, private) where the appliances are going to be deployed in

### Variables

```h
#aws_assumed_role_arn = "arn:aws:iam::<aws_account>:role/<assumed_role>" // This field is only necessary when an assumed role is required. Commented out by default.
aws_profile = "aws_profile" // The AWS profile configured for credentials OR matching AWS_PROFILE environment variable
aws_cred_file = "~/.aws/credentials" // An AWS credentials file to specify your credentials
aws_region = "xx-xxxx-x" // The AWS region to deploy the appliance in
vpc_id = "vpc-xxxxxxxx" // Specify the VPC ID where the appliance will be deployed in
vpc_cidr = "10.10.0.0/16" // Specify the VPC CIDR block
ci_subnet_id = "subnet-xxxxxxxx" // Specify the existing subnet ID where the scanning appliance will be deployed in
ci_subnet_type = "Public" // Select if the subnet is a public or private subnet. Enter Public or Private
ci_instance_type = "c5.large" // AlertLogic Security Appliance EC2 instance type. Enter m4.large, m4.xlarge, m4.2xlarge, m5.large, m5.xlarge, m5.2xlarge, c4.large, c4.xlarge, c4.2xlarge, c5.large, c5.xlarge or c5.2xlarge
ci_appliance_number = "1" // Number of Secuirty appliances to be deployed set by the Autoscaling group
ids_subnet_id = "subnet-xxxxxxxx" // Specify the existing subnet ID where the appliance will be deployed in
ids_subnet_type = "Public" // Select if the subnet is a public or private subnet. Enter Public or Private
ids_instance_type = "c5.xlarge" // AlertLogic IDS Appliance EC2 instance type. Enter m4.large, m4.xlarge, m4.2xlarge, m5.large, m5.xlarge, m5.2xlarge, c4.large, c4.xlarge, c4.2xlarge, c5.large, c5.xlarge or c5.2xlarge
ids_appliance_number = "1" // Number of IDS appliances to be deployed set by the Autoscaling group
```

### Infrastructure

The template will create the following resources in each Subnet provided (see [Appendix A](#appendix-a-resource-properties) for details on each resource):

- A [security group](#security-group) for the Scanning appliance
- A security [launch template](#security-launch-template) for the Scanning appliance
- A security [auto scaling group](#security-auto-scaling-group) with a single instance (default) for the Scanning appliance
- A [security group](#security-group) for the IDS appliance (if create_ids is set to 1)
- A security [launch template](#security-launch-template) for the IDS appliance (if create_ids is set to 1)
- A security [auto scaling group](#security-auto-scaling-group) with a single instance (default) for the IDS appliance (if create_ids is set to 1)

## How to Use

1. clone or download the entire repository to your working directory, i.e. ~/aws-manual-deployment

   ```text
   ├── deploy.tf
   ├── module
   │   ├── ci_scan
   │   │   ├── main.tf
   │   │   ├── outputs.tf
   │   │   └── variables.tf
   │   └── ids
   │       ├── main.tf
   │       ├── outputs.tf
   │       └── variables.tf
   ├── README.md
   └── vars.tfvars

   3 directories, 9 files
   ```

2. add all the required variable values in a separate file under the same directory, i.e. vars.tfvars
3. run Terraform initialization and apply to create the security resources in AWS:

   ```bash
      terraform init
      terraform apply -var-file=vars.tfvars
   ```

   **Provider configuration:**
   The configuration applied to this terraform uses a shared_credentials_file method. Credentials can be provided from separate file (default file name is credentials.tf)
   Variables can be loaded from separate file or passed as parameters. See <https://www.terraform.io/docs/providers/aws/#authentication> for more options.

   If you need to assume a role with your user account, then you will need to replace the existing "aws" provider section with the below: 
   provider "aws" { 
     assume_role { 
       role_arn = var.aws_assumed_role_arn 
     } 
     shared_credentials_file = var.aws_cred_file 
     profile = var.aws_profile 
     region = var.aws_region
   } 

   Make sure to add the following variable to the variables section below:
   variable "aws_assumed_role_arn" {}

   Make sure that you uncomment the section in the vars.tfvars file for the assumed role as well.

## Appendix A: Resource properties

This section provides details about each resource created by the template.

### Security Group

Every security group is configured to have following attributes:

| Attribute Name | Attribute Value                                                                          |
| -------------- | ---------------------------------------------------------------------------------------- |
| name           | AlertLogic IDS/Scan Security Group <VpcId> |
| description    | AlertLogic IDS/Scan Security Group                                                   |

As appliances needs to connect to Alert Logic back-end as well as access to customer infrastructure inside a VPC, the following rules are configured (taken from [here](https://docs.alertlogic.com/requirements/cloud/amazon-web-services-threat-manager-requirements.htm)):

_For Scanning:_

| direction | protocol | ports | CIDR             | Notes                                                    |
| --------- | -------- | ----- | ---------------- | -------------------------------------------------------- |
| out       | tcp      | 53    | 0.0.0.0/0        | DNS operations                                           |
| out       | tcp      | 443   | 0.0.0.0/0        | Appliance updates to backend over HTTPs                  |
| out       | udp      | 53    | 0.0.0.0/0        | DNS operations                                           |
| out       | all      | all   | \<VpcCidrBlock\> | Internal scans functionality                             |

_For IDS:_

| direction | protocol | ports | CIDR             | Notes                                       |
| --------- | -------- | ----- | ---------------- | ------------------------------------------- |
| in        | tcp      | 443   | \<VpcCidrBlock\> | Agent updates (single point of egress only) |
| in        | tcp      | 7777  | \<VpcCidrBlock\> | Agent network data transport                |
| out       | tcp      | 53    | \<GoogleDNS\>    | DNS operations                              |
| out       | tcp      | 443   | \<AlertLogicDC\> | Appliance updates to backend                |
| out       | tcp      | 4138  | \<AlertLogicDC\> | Event transport to backend                  |

### Security Launch Template

Every launch template is configured to have following attributes:

| Attribute Name           | Attribute Value                                                                                                          |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------------ |
| name                     | AlertLogic-IDS/Scan-Template-<VpcID>-idsappliance                                                                        |
| image_id                 | AMI ID depends on the region and is preconfigured in the template to have the latest version                             |
| instance_type            | This is the instance type set as input parameter                                                                         |

**NOTE**: The AMI IDs used are shared automatically with the AWS account by Alert Logic when the deployment is created in the UI.

### Security Auto Scaling Group

Every group is configured to have following attributes:

| Attribute Name  | Attribute Value                                                                             |
| --------------- | ------------------------------------------------------------------------------------------- |
| name            | AlertLogic IDS/Scan ASG <VpcId> |
| DesiredCapacity | Provided appliance number or 1 if not provided                                              |