# ids

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.ids_appliance_asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_launch_configuration.ids_appliance_lc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration) | resource |
| [aws_security_group.ids_appliance_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | AlertLogic Account ID. | `any` | n/a | yes |
| <a name="input_aws_amis"></a> [aws\_amis](#input\_aws\_amis) | the latest AMI is provided by Alert Logic and should have been previously shared with the AWS account deploying the IDS security appliance | `map(string)` | <pre>{<br>  "af-south-1": "ami-09d8ae18fd9476943",<br>  "ap-east-1": "ami-0b9f781c078c2bb96",<br>  "ap-northeast-1": "ami-02f58faca668c94be",<br>  "ap-northeast-2": "ami-06ba7f4d7cb1a40b0",<br>  "ap-northeast-3": "ami-0d2d1c31f99770410",<br>  "ap-south-1": "ami-0f0f2c10573854e73",<br>  "ap-southeast-1": "ami-0feddb0c6dffb4dbb",<br>  "ap-southeast-2": "ami-059b5f8e11db86595",<br>  "ap-southeast-3": "ami-04ace3ec9879885eb",<br>  "ap-southeast-4": "ami-0a72d224fe13ece7e",<br>  "ca-central-1": "ami-0f47133df1300b88a",<br>  "eu-central-1": "ami-0a337de49c7e8caab",<br>  "eu-central-2": "ami-083639a5df843922a",<br>  "eu-north-1": "ami-079e7eb0df4f17a2f",<br>  "eu-south-1": "ami-0fa3392bec43a2749",<br>  "eu-south-2": "ami-00a8cdc73359f9dc5",<br>  "eu-west-1": "ami-07dada231e617e70e",<br>  "eu-west-2": "ami-0f0d8db0584b81dc9",<br>  "eu-west-3": "ami-0f9bc8db76f626c3e",<br>  "me-south-1": "ami-0a03a45f8665c8642",<br>  "sa-east-1": "ami-0b5c9b59460471297",<br>  "us-east-1": "ami-06e37f930d7212ff4",<br>  "us-east-2": "ami-02817266095676d85",<br>  "us-gov-east-1": "ami-0f9c81dc1da6c15d7",<br>  "us-gov-west-1": "ami-0a03d3558bc0f1778",<br>  "us-west-1": "ami-005b03cb4a5de6210",<br>  "us-west-2": "ami-02aefdaa7e0441957"<br>}</pre> | no |
| <a name="input_create_ids"></a> [create\_ids](#input\_create\_ids) | Set value to 1(true) to include IDS coverage for the Professional protection subscription tier, otherwise set to 0(false) if your scope of protection set to Essentials/Scanning only, IDS will not be deployed. | `any` | n/a | yes |
| <a name="input_deployment_id"></a> [deployment\_id](#input\_deployment\_id) | AlertLogic cloudinsight Deployment ID. | `any` | n/a | yes |
| <a name="input_ids_appliance_number"></a> [ids\_appliance\_number](#input\_ids\_appliance\_number) | Number of appliances to be deployed set by the Autoscaling group. | `any` | n/a | yes |
| <a name="input_ids_instance_type"></a> [ids\_instance\_type](#input\_ids\_instance\_type) | AlertLogic Security Appliance EC2 instance type. Enter m3.medium, m3.large, m3.xlarge or m3.2xlarge | `string` | `"m3.medium"` | no |
| <a name="input_ids_subnet_id"></a> [ids\_subnet\_id](#input\_ids\_subnet\_id) | Specify the existing subnet ID(s) where the appliance will be deployed in. | `list(string)` | n/a | yes |
| <a name="input_ids_subnet_type"></a> [ids\_subnet\_type](#input\_ids\_subnet\_type) | Select if the subnet is a public or private subnet. Enter Public or Private | `any` | n/a | yes |
| <a name="input_internal"></a> [internal](#input\_internal) | Internal tags for tracking deployment versions | `string` | `"3.0.0"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR netblock of the VPC to be monitored (Where agents will be installed). | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Specify the VPC ID where the appliance will be deployed in. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_IDSDeployedInSubnetIDs"></a> [IDSDeployedInSubnetIDs](#output\_IDSDeployedInSubnetIDs) | n/a |
| <a name="output_IDSSecurityGroupID"></a> [IDSSecurityGroupID](#output\_IDSSecurityGroupID) | n/a |
| <a name="output_NumberOfIDSAppliancesDeployed"></a> [NumberOfIDSAppliancesDeployed](#output\_NumberOfIDSAppliancesDeployed) | n/a |
| <a name="output_ProtectedAccount"></a> [ProtectedAccount](#output\_ProtectedAccount) | n/a |
| <a name="output_ProtectedVPC"></a> [ProtectedVPC](#output\_ProtectedVPC) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
