module "front_end" {
    source = "../../terraform-sg-module"
    sg_name = var.frontend_sg_name
    sg_description = var.frontend_sg_description
    vpc_id = local.vpc_id
    project = var.project
    environment = var.environment

}

module "bastion" {
    source = "../../terraform-sg-module"
    # source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    sg_name = var.bastion_sg_name
    sg_description = var.bastion_sg_description
    vpc_id = local.vpc_id
}


module "backend_alb" {
    source = "../../terraform-sg-module"
    # source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    sg_name = var.backend_alb_sg_name
    sg_description = var.backend_alb_sg_description
    vpc_id = local.vpc_id
}

module "vpn" {
    source = "../../terraform-sg-module"
    # source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    sg_name = var.vpn_sg_name
    sg_description = var.vpn_sg_description
    vpc_id = local.vpc_id
}

module "mongodb" {
    source = "../../terraform-sg-module"
    # source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    sg_name = "momgodb"
    sg_description = "mongodb_security group"
    vpc_id = local.vpc_id
}


# bastion accepting connections from my laptop
resource "aws_security_group_rule" "bastion_laptop" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
  description       = "Allow SSH from anywhere"
}


# backend alb accepting connections from my bastion host
resource "aws_security_group_rule" "mongodb_vpn" {
  count = length(var.mongodb_ports)
  type              = "ingress"
  from_port         = var.mongodb_ports[count.index]
  to_port           = var.mongodb_ports[count.index]
  protocol          = "tcp"
  source_security_group_id       = module.vpn.sg_id
  security_group_id = module.mongodb.sg_id
  description       = "Allow ${var.mongodb_ports[count.index]}"
}

# backend alb accepting connections from my bastion host
resource "aws_security_group_rule" "bastion_backedn_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id       = module.bastion.sg_id
  security_group_id = module.backend_alb.sg_id
  description       = "Allow SSH from anywhere"
}
resource "aws_security_group_rule" "vpn_backedn_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id       = module.vpn.sg_id
  security_group_id = module.backend_alb.sg_id
  description       = "Allow SSH from anywhere"
}

# allow the ports 22, 443, 1194, 943
resource "aws_security_group_rule" "vpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
  description       = "Allow SSH from anywhere"
}
resource "aws_security_group_rule" "vpn_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
  description       = "Allow https from anywhere"
}

resource "aws_security_group_rule" "vpn_1194" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
  description       = "Allow 1194 from anywhere"
}
resource "aws_security_group_rule" "vpn_943" {
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
  description       = "Allow 943 from anywhere"
}