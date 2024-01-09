output "ProtectedVPC" {
  value = var.vpc_id
}

output "NumberOfIDSAppliancesDeployed" {
  value = var.ids_appliance_number
}

output "IDSSecurityGroupID" {
  value = aws_cloudformation_stack.idsappliance.outputs["SecurityGroupId"]
}

output "IDSDeployedInSubnetIDs" {
  value = "${var.ids_subnet_id}/${var.ids_subnet_type}"
}

