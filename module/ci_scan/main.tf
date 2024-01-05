// Data sources
data "aws_region" "current" {
}

// create launch template for the security appliances to be created
resource "aws_launch_template" "ci_appliance_lt" {
  name_prefix                 = "AlertLogic-Scan-Template-${var.vpc_id}"
  image_id                    = var.aws_amis[data.aws_region.current.name]
  network_interfaces {
    security_groups           = [aws_security_group.ci_appliance_sg.id]
    associate_public_ip_address = var.ci_subnet_type == "Public" ? true : false
  }
  instance_type               = var.ci_instance_type

  lifecycle {
    create_before_destroy = true
  }
}


// create ASG to have the specified amount of security appliances up and running using the created launch configuration
resource "aws_autoscaling_group" "ci_appliance_asg" {
  name                 = "AlertLogic-Scan-ASG-${var.vpc_id}"
  max_size             = var.ci_appliance_number
  min_size             = var.ci_appliance_number
  desired_capacity     = var.ci_appliance_number
  force_delete         = true
  launch_template {
    name               = aws_launch_template.ci_appliance_lt.name
  } 
  vpc_zone_identifier  = var.ci_subnet_id[*]

  lifecycle {
    create_before_destroy = true
  }

  tags = [
    {
      key                 = "Name"
      value               = "AlertLogic Security Appliance"
      propagate_at_launch = "true"
    },
    {
      key                 = "AlertLogic"
      value               = "Security"
      propagate_at_launch = "true"
    },
    {
      key                 = "AlertLogic Scan Manual Mode Template Version"
      value               = var.internal
      propagate_at_launch = "true"
    }
  ]
}

// create security group to allow security appliance traffic to flow outbound to any destination IP on specific ports. In general, it will have no rules, which basically allows all traffic outbound but is resitricted to specific ports required for communication
resource "aws_security_group" "ci_appliance_sg" {
  name        = "AlertLogic Scan Security Group - ${var.vpc_id}"
  description = "AlertLogic Scan Security Group"
  vpc_id      = var.vpc_id

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
    "Name"                                                      = "AlertLogic Scan Security Group - ${var.vpc_id}"
    "AlertLogic"                                                = "Security"
    "Alertlogic CI Scan Appliance Manual Mode Template Version" = var.internal
  }
}
