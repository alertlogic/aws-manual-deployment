// Specify the provider and alternative access details below if needed
provider "aws" {
  shared_credentials_file = var.aws_cred_file
  profile                 = var.aws_profile
  region                  = var.aws_region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

module "ci_scan" {
  source = "./module/ci_scan"

  vpc_id              = var.vpc_id
  vpc_cidr            = var.vpc_cidr
  ci_subnet_id        = var.ci_subnet_id
  ci_subnet_type      = var.ci_subnet_type
  ci_instance_type    = var.ci_instance_type
  ci_appliance_number = var.ci_appliance_number
}

module "ids" {
  source = "./module/ids"

  vpc_id               = var.vpc_id
  vpc_cidr             = var.vpc_cidr
  ids_subnet_id        = var.ids_subnet_id
  ids_subnet_type      = var.ids_subnet_type
  ids_instance_type    = var.ids_instance_type
  ids_appliance_number = var.ids_appliance_number
}

variable "aws_profile" {
}

variable "aws_cred_file" {
}

variable "aws_region" {
}

variable "vpc_id" {
}

variable "vpc_cidr" {
}

variable "ci_subnet_id" {
}

variable "ci_subnet_type" {
}

variable "ids_subnet_type" {
}

variable "ci_instance_type" {
    default = "c5.large"
}

variable "ci_appliance_number" {
}

variable "ids_subnet_id" {
}
variable "ids_instance_type" {
  default = "c5.xlarge"
}

variable "ids_appliance_number" {
}

output ProtectedVPC {
  value = module.ci_scan.ProtectedVPC
}

output NumberOfSecurityAppliancesDeployed {
  value = module.ci_scan.NumberOfSecurityAppliancesDeployed
}

output CISecurityGroupID {
  value = module.ci_scan.CISecurityGroupID
}

output ScannerDeployedInSubnetID {
  value = module.ci_scan.ScannerDeployedInSubnetID
}

output NumberOfIDSAppliancesDeployed {
  value = module.ids.NumberOfIDSAppliancesDeployed
}

output IDSSecurityGroupID {
  value = module.ids.IDSSecurityGroupID
}

output IDSDeployedInSubnetIDs {
  value = module.ids.IDSDeployedInSubnetIDs
}