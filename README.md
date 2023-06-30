# Terraform for Manual Mode Deployments in AWS

Collection of Terraform modules to manually deploy Vulnerability Scanning and IDS required infrastructure into an existing customer managed subnet in AWS.

- [Overview](#overview)
- [Use Case: Customer provided subnet](#use-case-customer-provided-subnet)
- [How to Use](#how-to-use)
- [Appendix A](#appendix-a-resource-properties)

## Overview

This template is intended to be used by the customer when `manual` deployment mode is selected for `Detection`.

The template included here will take care of the creation of the whole infrastructure required to create a working IDS appliance. However, further steps are required to have a fully functional appliance.

## Use Case: Customer provided subnet

In this use case, the customer provides an existing subnet where the appliances are going to be deployed in.

**NOTE**: It is the customer's responsibility to properly configure network access to the chosen subnet. This includes management of IGW, Routes, NACLs and NAT associated with the existing subnet. Scan and IDS appliances must be able to communicate with our Datacenters via IGW or NAT Gateway/NAT instance.

### Requirements

In order to deploy the appliances these requirements must be done prior:

- Terraform version 14.1 thru 14.11.
   - For v0.11, use the [v0.11] (https://github.com/al-deployment-services/aws-manual-deployment/tree/v0.11) branch.
   - For v0.12, use the [v0.12] (https://github.com/al-deployment-services/aws-manual-deployment/tree/v0.12) branch.
   - For the latest terraform version, use master branch
- A `manual` mode AWS deployment exist in the Alert Logic console
- `manual` mode deployments needs to have scope set to at least one VPC
- AWS VPC ID and CIDR where the appliances will be deployed in
- Subnet IDs and type (public, private) where the appliances are going to be deployed in

### Variables

```h
#aws_assumed_role_arn = "arn:aws:iam::<aws_account>:role/<assumed_role>" // This field is only necessary when an assumed role is required. Commented out by default.
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
```

### Infrastructure

The template will create the following resources in each Subnet provided (see [Appendix A](#appendix-a-resource-properties) for details on each resource):

- A [security group](#security-group) for the Scanning appliance
- A security [launch configuration](#security-launch-configuration) for the Scanning appliance
- A security [auto scaling group](#security-auto-scaling-group) with a single instance (default) for the Scanning appliance
- A [security group](#security-group) for the IDS appliance (if create_ids is set to 1)
- A security [launch configuration](#security-launch-configuration) for the IDS appliance (if create_ids is set to 1)
- A security [auto scaling group](#security-auto-scaling-group) with a single instance (default) for the IDS appliance (if create_ids is set to 1)

## How to Use

1. clone or download the entire repository to your working directory, i.e. ~/aws-manual-deployment

   ```text
   ├── deploy.tf
   ├── module
   │   ├── ci_scan
   │   │   ├── main.tf
   │   │   ├── outputs.tf
   │   │   ├── userdata.tpl
   │   │   └── variables.tf
   │   └── ids
   │       ├── main.tf
   │       ├── outputs.tf
   │       └── variables.tf
   ├── README.md
   └── vars.tfvars

   3 directories, 10 files
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

### Shared tagging

All resources created will have a set of shared tags as shown in the next table:

| Tag Name                                             | Tag Value        |
| ---------------------------------------------------- | ---------------- |
| AlertLogic-AccountID                                 | \<AccountId\>    |
| AlertLogic-EnvironmentID                             | \<DeploymentId\> |
| AlertLogic                                           | Security         |
| Alertlogic Security/IDS Manual Mode Template Version | vx.x.x           |

**NOTE**: A unique tag `Name` will be set per resource type.

### Security Group

Every security group is configured to have following attributes:

| Attribute Name | Attribute Value                                                                          |
| -------------- | ---------------------------------------------------------------------------------------- |
| name           | AlertLogic Security/IDS Security Group \<AccountId\>/\<DeploymentId\>/\<AzId\>/\<VpcId\> |
| description    | AlertLogic Security/IDS Security Group                                                   |

Following tags will be set on every security group:

| Tag Name | Tag Value                                                                                |
| -------- | ---------------------------------------------------------------------------------------- |
| Name     | AlertLogic Security/IDS Security Group \<AccountId\>/\<DeploymentId\>/\<AzId\>/\<VpcId\> |

As appliances needs to connect to Alert Logic back-end as well as access to customer infrastructure inside a VPC, the following rules are configured (taken from [here](https://docs.alertlogic.com/requirements/cloud/amazon-web-services-threat-manager-requirements.htm)):

_For Scanning:_

| direction | protocol | ports | CIDR             | Notes                                                    |
| --------- | -------- | ----- | ---------------- | -------------------------------------------------------- |
| out       | tcp      | 22    | 0.0.0.0/0        | To connect to the backend and download scanning software |
| out       | tcp      | 53    | 0.0.0.0/0        | DNS operations                                           |
| out       | tcp      | 80    | 0.0.0.0/0        | Appliance updates to backend over HTTP                   |
| out       | tcp      | 443   | 0.0.0.0/0        | Appliance updates to backend over HTTPs                  |
| out       | udp      | 53    | 0.0.0.0/0        | DNS operations                                           |
| out       | all      | all   | \<VpcCidrBlock\> | Internal scans functionality                             |

_For IDS:_

| direction | protocol | ports | CIDR             | Notes                                       |
| --------- | -------- | ----- | ---------------- | ------------------------------------------- |
| in        | tcp      | 443   | \<VpcCidrBlock\> | Agent updates (single point of egress only) |
| in        | tcp      | 7777  | \<VpcCidrBlock\> | Agent network data transport                |
| out       | tcp      | 53    | \<GoogleDNS\>    | DNS operations                              |
| out       | tcp      | 80    | 0.0.0.0/0        | Appliance updates to backend                |
| out       | tcp      | 443   | \<AlertLogicDC\> | Appliance updates to backend                |
| out       | tcp      | 4138  | \<AlertLogicDC\> | Event transport to backend                  |
| out       | udp      | 53    | \<GoogleDNS\>    | DNS operations                              |
| out       | udp      | 123   | \<AlertLogicDC\> | NTP sync                                    |

### Security Launch Configuration

Every launch configuration is configured to have following attributes:

| Attribute Name           | Attribute Value                                                                                                          |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------------ |
| name                     | AlertLogic Security/IDS Launch Configuration \<AccountId\>/\<DeploymentId\>/\<AzId\>/\<VpcId\>                           |
| description              | AlertLogic Launch Configuration for Security/IDS                                                                         |
| image_id                 | AMI ID depends on the region and is preconfigured in the template to have the latest version                             |
| instance_type            | This is the instance type set as input parameter                                                                         |
| AssociatePublicIpAddress | `true` so appliance can have external connectivity through the IGW if `public` subnet type is chosen, otherwise is false |

Following tags will be set on every launch configuration:

| Tag Name | Tag Value                                                                                      |
| -------- | ---------------------------------------------------------------------------------------------- |
| Name     | AlertLogic Security/IDS Launch Configuration \<AccountId\>/\<DeploymentId\>/\<AzId\>/\<VpcId\> |

**NOTE**: The AMI IDs used are shared automatically with the AWS account by Alert Logic when the deployment is created in the UI.

### Security Auto Scaling Group

Every group is configured to have following attributes:

| Attribute Name  | Attribute Value                                                                             |
| --------------- | ------------------------------------------------------------------------------------------- |
| name            | AlertLogic Security/IDS Autoscaling Group \<AccountId\>/\<DeploymentId\>/\<AzId\>/\<VpcId\> |
| DesiredCapacity | Provided appliance number or 1 if not provided                                              |

The autosclaing group is configured to propagate the following tags to every launched instance (besides the previously defined list of shared tags):

| Tag Name | Tag Value                         |
| -------- | --------------------------------- |
| Name     | AlertLogic Security/IDS Appliance |<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | ~> 2.1.2 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ci_scan"></a> [ci\_scan](#module\_ci\_scan) | ./module/ci_scan | n/a |
| <a name="module_ids"></a> [ids](#module\_ids) | ./module/ids | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | n/a | `any` | n/a | yes |
| <a name="input_aws_cred_file"></a> [aws\_cred\_file](#input\_aws\_cred\_file) | n/a | `any` | n/a | yes |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | n/a | `any` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `any` | n/a | yes |
| <a name="input_ci_appliance_number"></a> [ci\_appliance\_number](#input\_ci\_appliance\_number) | n/a | `any` | n/a | yes |
| <a name="input_ci_instance_type"></a> [ci\_instance\_type](#input\_ci\_instance\_type) | n/a | `any` | n/a | yes |
| <a name="input_ci_subnet_id"></a> [ci\_subnet\_id](#input\_ci\_subnet\_id) | n/a | `any` | n/a | yes |
| <a name="input_ci_subnet_type"></a> [ci\_subnet\_type](#input\_ci\_subnet\_type) | n/a | `any` | n/a | yes |
| <a name="input_create_ids"></a> [create\_ids](#input\_create\_ids) | n/a | `any` | n/a | yes |
| <a name="input_deployment_id"></a> [deployment\_id](#input\_deployment\_id) | n/a | `any` | n/a | yes |
| <a name="input_ids_appliance_number"></a> [ids\_appliance\_number](#input\_ids\_appliance\_number) | n/a | `any` | n/a | yes |
| <a name="input_ids_instance_type"></a> [ids\_instance\_type](#input\_ids\_instance\_type) | n/a | `any` | n/a | yes |
| <a name="input_ids_subnet_id"></a> [ids\_subnet\_id](#input\_ids\_subnet\_id) | n/a | `list(string)` | n/a | yes |
| <a name="input_ids_subnet_type"></a> [ids\_subnet\_type](#input\_ids\_subnet\_type) | n/a | `any` | n/a | yes |
| <a name="input_stack"></a> [stack](#input\_stack) | n/a | `any` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | n/a | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_CISecurityGroupID"></a> [CISecurityGroupID](#output\_CISecurityGroupID) | n/a |
| <a name="output_IDSDeployedInSubnetIDs"></a> [IDSDeployedInSubnetIDs](#output\_IDSDeployedInSubnetIDs) | n/a |
| <a name="output_IDSSecurityGroupID"></a> [IDSSecurityGroupID](#output\_IDSSecurityGroupID) | n/a |
| <a name="output_NumberOfIDSAppliancesDeployed"></a> [NumberOfIDSAppliancesDeployed](#output\_NumberOfIDSAppliancesDeployed) | n/a |
| <a name="output_NumberOfSecurityAppliancesDeployed"></a> [NumberOfSecurityAppliancesDeployed](#output\_NumberOfSecurityAppliancesDeployed) | n/a |
| <a name="output_ProtectedAccount"></a> [ProtectedAccount](#output\_ProtectedAccount) | n/a |
| <a name="output_ProtectedVPC"></a> [ProtectedVPC](#output\_ProtectedVPC) | n/a |
| <a name="output_ScannerDeployedInSubnetID"></a> [ScannerDeployedInSubnetID](#output\_ScannerDeployedInSubnetID) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
