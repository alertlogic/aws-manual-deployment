output "ProtectedVPC" {
  value = var.vpc_id
}

output "CISecurityGroupID" {
  value = aws_cloudformation_stack.scanappliance.outputs["SecurityGroupId"]
}

output "ScannerDeployedInSubnetID" {
  value = "${var.ci_subnet_id}/${var.ci_subnet_type}"
}

