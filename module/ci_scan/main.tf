resource "aws_cloudformation_stack" "scanappliance" {
  name = "scanappliance"
  parameters = {
        VpcId = var.vpc_id
        VpcCidr = var.vpc_cidr
        SubnetId = var.ci_subnet_id
        AssignPublicIp = var.ci_subnet_type == "Public" ? true : false
        InstanceType = var.ci_instance_type
  }
  template_url = "https://s3.amazonaws.com/cd.prod.manual-mode.repository/cf_templates_latest/al_scan.yaml"
  capabilities = ["CAPABILITY_AUTO_EXPAND"]
}
