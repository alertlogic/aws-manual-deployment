output "ProtectedVPC" {
  value = var.vpc_id
}

output "NumberOfSecurityAppliancesDeployed" {
  value = var.ci_appliance_number
}

output "CISecurityGroupID" {
  value = aws_cloudformation_stack.scanappliance.outputs["SecurityGroupId"]
}

output "ScannerDeployedInSubnetID" {
  value = "${var.ci_subnet_id}/${var.ci_subnet_type}"
}

