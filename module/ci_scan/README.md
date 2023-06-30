# ci_scan

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.ci_appliance_asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_launch_configuration.ci_appliance_lc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration) | resource |
| [aws_security_group.ci_appliance_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [template_file.userdata](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | AlertLogic Account ID. | `any` | n/a | yes |
| <a name="input_aws_amis"></a> [aws\_amis](#input\_aws\_amis) | the latest AMI is provided by Alert Logic and should have been previously shared with the AWS account deploying the security appliance | `map(string)` | <pre>{<br>  "af-south-1": "ami-0a4979950cb37691e",<br>  "ap-east-1": "ami-0a8bff24b3e55224b",<br>  "ap-northeast-1": "ami-0e9664a9fcbf01220",<br>  "ap-northeast-2": "ami-0c0adcc9d3bf64cad",<br>  "ap-northeast-3": "ami-0ede4174a29f36f71",<br>  "ap-south-1": "ami-0f4fb35dea6c310c1",<br>  "ap-southeast-1": "ami-07c7a65a21c3ccd58",<br>  "ap-southeast-2": "ami-0b324b4d4cc6753cb",<br>  "ap-southeast-3": "ami-02c13c56c0e9d8c99",<br>  "ap-southeast-4": "ami-095d6d1a718ca6098",<br>  "ca-central-1": "ami-08c790ee5bad56836",<br>  "eu-central-1": "ami-01fd7c1b7f4d969b4",<br>  "eu-central-2": "ami-0c77ad1e182233176",<br>  "eu-north-1": "ami-06847c2a54fab56cc",<br>  "eu-south-1": "ami-02e8d8010af7072ac",<br>  "eu-south-2": "ami-06f2f18633c07ac3d",<br>  "eu-west-1": "ami-0c5f94fee8ca0e911",<br>  "eu-west-2": "ami-06d203499484c5431",<br>  "eu-west-3": "ami-0338227e0ab6ac5d1",<br>  "me-south-1": "ami-00716048f6f598b95",<br>  "sa-east-1": "ami-0256e6e7d007627d0",<br>  "us-east-1": "ami-02e38d2e4fdf655ad",<br>  "us-east-2": "ami-062df8079ee0fb7f0",<br>  "us-west-1": "ami-0183a32d7abcc1ec5",<br>  "us-west-2": "ami-05cb3bacd3020afe6"<br>}</pre> | no |
| <a name="input_ci_appliance_number"></a> [ci\_appliance\_number](#input\_ci\_appliance\_number) | Number of appliances to be deployed set by the Autoscaling group. | `string` | `"1"` | no |
| <a name="input_ci_instance_type"></a> [ci\_instance\_type](#input\_ci\_instance\_type) | AlertLogic Security Appliance EC2 instance type. Enter m3.medium, m3.large, m3.xlarge or m3.2xlarge | `string` | `"m3.medium"` | no |
| <a name="input_ci_subnet_id"></a> [ci\_subnet\_id](#input\_ci\_subnet\_id) | Specify the existing subnet ID where the Scanning appliance will be deployed in. | `any` | n/a | yes |
| <a name="input_ci_subnet_type"></a> [ci\_subnet\_type](#input\_ci\_subnet\_type) | Select if the subnet is a public or private subnet. Enter Public or Private | `any` | n/a | yes |
| <a name="input_deployment_id"></a> [deployment\_id](#input\_deployment\_id) | AlertLogic cloudinsight Deployment ID. | `any` | n/a | yes |
| <a name="input_internal"></a> [internal](#input\_internal) | Internal tags for tracking deployment versions | `string` | `"3.0.0"` | no |
| <a name="input_stack"></a> [stack](#input\_stack) | AlertLogic DataCenter where the appliance will be deployed in. Enter US or UK | `string` | `"US"` | no |
| <a name="input_stack_vaporator"></a> [stack\_vaporator](#input\_stack\_vaporator) | n/a | `map(string)` | <pre>{<br>  "UK.host": "agentapi.cloudinsight.alertlogic.co.uk",<br>  "UK.port": "443",<br>  "US.host": "agentapi.cloudinsight.alertlogic.com",<br>  "US.port": "443"<br>}</pre> | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR netblock for the VPC. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Specify the VPC ID where the appliance will be deployed in. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_CISecurityGroupID"></a> [CISecurityGroupID](#output\_CISecurityGroupID) | n/a |
| <a name="output_NumberOfSecurityAppliancesDeployed"></a> [NumberOfSecurityAppliancesDeployed](#output\_NumberOfSecurityAppliancesDeployed) | n/a |
| <a name="output_ProtectedAccount"></a> [ProtectedAccount](#output\_ProtectedAccount) | n/a |
| <a name="output_ProtectedVPC"></a> [ProtectedVPC](#output\_ProtectedVPC) | n/a |
| <a name="output_ScannerDeployedInSubnetID"></a> [ScannerDeployedInSubnetID](#output\_ScannerDeployedInSubnetID) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
