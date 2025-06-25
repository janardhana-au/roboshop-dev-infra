variable "frontend_sg" {
    type= string
    default = "frontend"
}

variable "frontend_sg_description" {
    type = string
    default = "frontend security group"
  
}

variable "vpc_id" {
    type = string
  
}

variable "project" {

    type = string
  
}

variable "environment" {
    type = string
  
}
