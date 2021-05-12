/*
TerraForm Template (v2.0): Supports Terraform 0.12 and later. Creates AlertLogic security appliance for Cloud Insight (Vulnerability Scanning) and IDS inside an existing VPC/Subnet.
The artifacts created are: A Security Group, a Launch Configuration for the security appliances that uses the Security Group and an Autoscaling Group that uses the Launch Configuration inside an existing Subnet.

Usage:
1. clone or download the entire repository to your working directory, i.e. ~/aws-manual-deployment
.
├── README.md
├── deploy.tf
├── module
│   ├── ci_scan
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── userdata.tpl
│   │   └── variables.tf
│   └── ids
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── vars.tfvars
└── versions.tf

3 directories, 11 files

2. add all the required variable values in a separate file under the same directory, i.e. vars.tfvars
3. run TerraForm initialization and apply to create the security resources in AWS:
   > terraform init
   > terraform apply -var-file=vars.tfvars

Provider configuration:
 The configuration applied below uses a shared_credentials_file method. Credentials can be provided from separate file (default file name is credentials.tf)
 Variables can be loaded from separate file or passed as parameters. See https://www.terraform.io/docs/providers/aws/#authentication for more options.
 
 If you need to assume a role with your user account, then you will need to replace the existing "aws" provider section with the below:
 provider "aws" {
   assume_role {
     role_arn = var.aws_assumed_role_arn
   }
   shared_credentials_file = var.aws_cred_file
   profile                 = var.aws_profile
   region                  = var.aws_region
 }

 Also add a variable in the variables section to match the below:
 variable "aws_assumed_role_arn" {
 }

 And make sure that you uncomment out the section in the vars.tfvars file for the assumed role.
*/

// Specify the provider and alternative access details below if needed
provider "aws" {
  shared_credentials_file = var.aws_cred_file
  profile                 = var.aws_profile
  assume_role {
     role_arn = var.aws_assumed_role_arn
  }
  region                  = var.aws_region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.1.2"
    }
  }
}

module "ci_scan" {
  source = "./module/ci_scan"

  account_id          = var.account_id
  deployment_id       = var.deployment_id
  stack               = var.stack
  vpc_id              = var.vpc_id
  ci_subnet_id        = var.ci_subnet_id
  ci_subnet_type      = var.ci_subnet_type
  vpc_cidr            = var.vpc_cidr
  ci_instance_type    = var.ci_instance_type
  ci_appliance_number = var.ci_appliance_number
}

module "ids" {
  source = "./module/ids"

  account_id           = var.account_id
  deployment_id        = var.deployment_id
  create_ids           = var.create_ids
  vpc_id               = var.vpc_id
  ids_subnet_id        = var.ids_subnet_id
  ids_subnet_type      = var.ids_subnet_type
  vpc_cidr             = var.vpc_cidr
  ids_instance_type    = var.ids_instance_type
  ids_appliance_number = var.ids_appliance_number
}

variable "aws_assumed_role_arn" {
}

variable "aws_profile" {
}

variable "aws_cred_file" {
}

variable "aws_region" {
}

variable "account_id" {
}

variable "deployment_id" {
}

variable "stack" {
}

variable "create_ids" {
}

variable "vpc_id" {
}

variable "vpc_cidr" {
}

variable "ci_subnet_id" {
}

variable "ids_subnet_id" {
  type = list(string)
}

variable "ci_subnet_type" {
}

variable "ids_subnet_type" {
}

variable "ci_instance_type" {
}

variable "ci_appliance_number" {
}

variable "ids_instance_type" {
}

variable "ids_appliance_number" {
}

output ProtectedAccount {
  value = module.ci_scan.ProtectedAccount
}

output ProtectedVPC {
  value = module.ci_scan.ProtectedVPC
}

output ScannerDeployedInSubnetID {
  value = module.ci_scan.ScannerDeployedInSubnetID
}

output IDSDeployedInSubnetIDs {
  value = module.ids.IDSDeployedInSubnetIDs
}

output NumberOfSecurityAppliancesDeployed {
  value = module.ci_scan.NumberOfSecurityAppliancesDeployed
}

output NumberOfIDSAppliancesDeployed {
  value = module.ids.NumberOfIDSAppliancesDeployed
}

output CISecurityGroupID {
  value = module.ci_scan.CISecurityGroupID
}

output IDSSecurityGroupID {
  value = module.ids.IDSSecurityGroupID
}
