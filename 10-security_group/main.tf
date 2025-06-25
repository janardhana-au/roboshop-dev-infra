module "front_end" {
    source = "../../terraform-sg-module"
    sg_name = var.frontend_sg
    sg_description = var.frontend_sg_description
    vpc_id = var.vpc_id
    project = var.project
    environment = var.environment

}