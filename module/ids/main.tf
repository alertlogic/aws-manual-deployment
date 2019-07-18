// Data sources
data "aws_region" "current" {
}

// create launch configuration for the IDS security appliances to be created
resource "aws_launch_configuration" "ids_appliance_lc" {
  name_prefix                 = "AlertLogic IDS Security Launch Configuration ${var.account_id}/${var.deployment_id}/${var.vpc_id}_"
  count                       = var.create_ids
  image_id                    = var.aws_amis[data.aws_region.current.name]
  security_groups             = [aws_security_group.ids_appliance_sg[0].id]
  instance_type               = var.ids_instance_type
  associate_public_ip_address = var.ids_subnet_type == "Public" ? true : false

  lifecycle {
    create_before_destroy = true
  }
}

// create ASG to have the specified amount of IDS security appliances up and running using the created launch configuration
resource "aws_autoscaling_group" "ids_appliance_asg" {
  name                 = "AlertLogic IDS Security Autoscaling Group ${var.account_id}/${var.deployment_id}/${var.vpc_id}"
  count                = var.create_ids
  max_size             = var.ids_appliance_number
  min_size             = var.ids_appliance_number
  desired_capacity     = var.ids_appliance_number
  force_delete         = true
  launch_configuration = aws_launch_configuration.ids_appliance_lc[0].name
  vpc_zone_identifier  = var.ids_subnet_id

  lifecycle {
    create_before_destroy = true
  }

  tags = [
    {
      key                 = "Name"
      value               = "AlertLogic IDS Security Appliance"
      propagate_at_launch = "true"
    },
    {
      key                 = "AlertLogic-AccountID"
      value               = var.account_id
      propagate_at_launch = "true"
    },
    {
      key                 = "AlertLogic-EnvironmentID"
      value               = var.deployment_id
      propagate_at_launch = "true"
    },
    {
      key                 = "AlertLogic"
      value               = "Security"
      propagate_at_launch = "true"
    },
    {
      key                 = "Alertlogic IDS Manual Mode Template Version"
      value               = var.internal
      propagate_at_launch = "true"
    }
  ]
}

// create security group to allow IDS security appliance traffic to flow outbound to Alert Logic DataCenter (resitricted and required outbound rules will be applied)
resource "aws_security_group" "ids_appliance_sg" {
  name        = "AlertLogic IDS Security Group ${var.account_id}/${var.deployment_id}/${var.vpc_id}"
  count       = var.create_ids
  description = "AlertLogic IDS Security Group"
  vpc_id      = var.vpc_id

  ingress {
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
    from_port   = 7777
    to_port     = 7777
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
    from_port   = 443
    to_port     = 443
  }

  egress {
    protocol    = "tcp"
    cidr_blocks = ["204.110.218.96/27"]
    from_port   = 443
    to_port     = 443
  }

  egress {
    protocol    = "tcp"
    cidr_blocks = ["204.110.219.96/27"]
    from_port   = 443
    to_port     = 443
  }

  egress {
    protocol    = "tcp"
    cidr_blocks = ["208.71.209.32/27"]
    from_port   = 443
    to_port     = 443
  }

  egress {
    protocol    = "tcp"
    cidr_blocks = ["185.54.124.0/24"]
    from_port   = 443
    to_port     = 443
  }

  egress {
    protocol    = "tcp"
    cidr_blocks = ["204.110.218.96/27"]
    from_port   = 4138
    to_port     = 4138
  }

  egress {
    protocol    = "tcp"
    cidr_blocks = ["204.110.219.96/27"]
    from_port   = 4138
    to_port     = 4138
  }

  egress {
    protocol    = "tcp"
    cidr_blocks = ["208.71.209.32/27"]
    from_port   = 4138
    to_port     = 4138
  }

  egress {
    protocol    = "tcp"
    cidr_blocks = ["185.54.124.0/24"]
    from_port   = 4138
    to_port     = 4138
  }

  egress {
    protocol    = "udp"
    cidr_blocks = ["8.8.8.8/32"]
    from_port   = 53
    to_port     = 53
  }

  egress {
    protocol    = "udp"
    cidr_blocks = ["8.8.4.4/32"]
    from_port   = 53
    to_port     = 53
  }

  egress {
    protocol    = "tcp"
    cidr_blocks = ["8.8.8.8/32"]
    from_port   = 53
    to_port     = 53
  }

  egress {
    protocol    = "tcp"
    cidr_blocks = ["8.8.4.4/32"]
    from_port   = 53
    to_port     = 53
  }

  tags = {
    "Name"                                        = "AlertLogic IDS Security Group"
    "AlertLogic-AccountID"                        = var.account_id
    "AlertLogic-EnvironmentID"                    = var.deployment_id
    "AlertLogic"                                  = "Security"
    "Alertlogic IDS Manual Mode Template Version" = var.internal
  }
}
