output "ProtectedAccount" {
  value = module.ci_scan.ProtectedAccount
}

output "ProtectedVPC" {
  value = module.ci_scan.ProtectedVPC
}

output "ScannerDeployedInSubnetID" {
  value = module.ci_scan.ScannerDeployedInSubnetID
}

output "IDSDeployedInSubnetIDs" {
  value = module.ids.IDSDeployedInSubnetIDs
}

output "NumberOfSecurityAppliancesDeployed" {
  value = module.ci_scan.NumberOfSecurityAppliancesDeployed
}

output "NumberOfIDSAppliancesDeployed" {
  value = module.ids.NumberOfIDSAppliancesDeployed
}

output "CISecurityGroupID" {
  value = module.ci_scan.CISecurityGroupID
}

output "IDSSecurityGroupID" {
  value = module.ids.IDSSecurityGroupID
}
