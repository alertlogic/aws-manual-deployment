output "ProtectedAccount" {
  value = "${var.account_id}/${var.deployment_id}"
}

output "ProtectedVPC" {
  value = "${var.vpc_id}"
}

output "NumberOfSecurityAppliancesDeployed" {
  value = "${var.ci_appliance_number}"
}

output "CISecurityGroupID" {
  value = "${aws_security_group.ci_appliance_sg.id}"
}

output "DeployedInSubnetID" {
  value = "${var.subnet_id}/${var.subnet_type}"
}
