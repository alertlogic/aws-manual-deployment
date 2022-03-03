/*
TerraForm Template (v3.0): Supports Terraform 0.14 and later. Creates AlertLogic security appliance for Cloud Insight (Vulnerability Scanning) and IDS inside an existing VPC/Subnet.
The artifacts created are: A Security Group, a Launch Configuration for the security appliances that uses the Security Group and an Autoscaling Group that uses the Launch Configuration inside an existing Subnet.

Usage:
1. clone or download the entire repository to your working directory, i.e. ~/aws-manual-deployment
.
├── README.md
├── main.tf
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
*/

module "ci_scan" {
  source = "./module/ci_scan"

  account_id          = var.account_id
  deployment_id       = var.deployment_id
  stack               = var.stack
  vpc_id              = var.vpc_id
  ci_subnet_ids       = var.ci_subnet_ids
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
  ids_subnet_ids       = var.ids_subnet_ids
  ids_subnet_type      = var.ids_subnet_type
  vpc_cidr             = var.vpc_cidr
  ids_instance_type    = var.ids_instance_type
  ids_appliance_number = var.ids_appliance_number
}
