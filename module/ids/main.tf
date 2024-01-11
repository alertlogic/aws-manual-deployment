resource "aws_cloudformation_stack" "idsappliance" {
  name = "idsappliance"
  parameters = {
        VpcId = var.vpc_id
        VpcCidr = var.vpc_cidr
        SubnetId = var.ids_subnet_id
        AssignPublicIp = var.ids_subnet_type == "Public" ? true : false
        InstanceType = var.ids_instance_type
        NumAppliances = var.ids_appliance_number
  }
  template_url = "https://s3.amazonaws.com/cd.prod.manual-mode.repository/cf_templates_latest/al_ids.yaml"
  capabilities = ["CAPABILITY_AUTO_EXPAND"]
}