variable "frontend_sg_name" {
    type= string
    default = "frontend"
}

variable "frontend_sg_description" {
    type = string
    default = "frontend security group" 
}

variable "project" {

    type = string
    default = "roboshop"
  
}

variable "environment" {
    type = string
    default = "dev"
  
}

variable "bastion_sg_name" {
    type= string
    default = "bastion"
}

variable "bastion_sg_description" {
    type = string
    default = "bastion security group" 
}
variable "backend_alb_sg_name" {
    type= string
    default = "backend_alb"
}

variable "backend_alb_sg_description" {
    type = string
    default = "backend security group" 
}

variable "vpn_sg_name" {
    type= string
    default = "vpn"
}

variable "vpn_sg_description" {
    type = string
    default = "vpn security group" 
}

variable "mongodb_ports" {
    type = list(string)
    default = ["22", "27017"]
  
}
