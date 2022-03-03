// Data sources
data "aws_region" "current" {
}

// initial setup of the security appliance, a bash bootstrap script is executed using AWS userdata functionality
data "template_file" "userdata" {
  template = file("${path.module}/userdata.tpl")

  vars = {
    stack_host    = var.stack_vaporator["${var.stack}.host"]
    stack_port    = var.stack_vaporator["${var.stack}.port"]
    account_id    = var.account_id
    deployment_id = var.deployment_id
  }
}

// create launch configuration for the security appliances to be created
resource "aws_launch_configuration" "ci_appliance_lc" {
  name_prefix                 = "AlertLogic Security Launch Configuration ${var.account_id}/${var.deployment_id}/${var.vpc_id}_"
  image_id                    = var.aws_amis[data.aws_region.current.name]
  security_groups             = [aws_security_group.ci_appliance_sg.id]
  instance_type               = var.ci_instance_type
  associate_public_ip_address = var.ci_subnet_type == "Public" ? true : false
  user_data                   = data.template_file.userdata.rendered

  lifecycle {
    create_before_destroy = true
  }
}

// create ASG to have the specified amount of security appliances up and running using the created launch configuration
resource "aws_autoscaling_group" "ci_appliance_asg" {
  name                 = "AlertLogic Security Autoscaling Group ${var.account_id}/${var.deployment_id}/${var.vpc_id}"
  max_size             = var.ci_appliance_number
  min_size             = var.ci_appliance_number
  desired_capacity     = var.ci_appliance_number
  force_delete         = true
  launch_configuration = aws_launch_configuration.ci_appliance_lc.name
  vpc_zone_identifier  = var.ci_subnet_ids

  lifecycle {
    create_before_destroy = true
  }

  dynamic "tag" {
    for_each = [
      {
        key   = "Name"
        value = "AlertLogic Security Appliance"
      },
      {
        key   = "AlertLogic-AccountID"
        value = var.account_id
      },
      {
        key   = "AlertLogic-EnvironmentID"
        value = var.deployment_id
      },
      {
        key   = "AlertLogic"
        value = "Security"
      },
      {
        key   = "Alertlogic CI Scan Appliance Manual Mode Template Version"
        value = var.internal
      }
    ]
    content {
      key                 = tag.key
      value               = tag.value["value"]
      propagate_at_launch = true
    }
  }
}

// create security group to allow security appliance traffic to flow outbound to any destination IP on specific ports. In general, it will have no rules, which basically allows all traffic outbound but is resitricted to specific ports required for communication
resource "aws_security_group" "ci_appliance_sg" {
  name        = "AlertLogic Security Group ${var.account_id}/${var.deployment_id}/${var.vpc_id}"
  description = "AlertLogic Security Group"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  tags = {
    "Name"                                                      = "AlertLogic Security Group"
    "AlertLogic-AccountID"                                      = var.account_id
    "AlertLogic-EnvironmentID"                                  = var.deployment_id
    "AlertLogic"                                                = "Security"
    "Alertlogic CI Scan Appliance Manual Mode Template Version" = var.internal
  }
}
