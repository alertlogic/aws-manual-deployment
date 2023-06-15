output "ProtectedAccount" {
  value = "${var.account_id}/${var.deployment_id}"
}

output "ProtectedVPC" {
  value = var.vpc_id
}

output "NumberOfIDSAppliancesDeployed" {
  value = var.ids_appliance_number
}

output "IDSSecurityGroupID" {
  value = aws_security_group.ids_appliance_sg.*.id
}

output "IDSDeployedInSubnetIDs" {
  value = var.ids_subnet_id
}
