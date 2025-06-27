terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.98.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

module "vpc" {
    source = "../../terraform-vpc-module"
    #source = "git::https://github.com/janardhana-au/terraform-vpc-module.git?ref=main"
    cidr_block = var.cidr_block
    project = var.project
    environment = var.environment
    public_subnet_cidrs = var.public_cidrs
    private_subnet_cidrs = var.private_cidrs
    database_subnet_cidrs = var.database_cidrs
    #is_peering_req = true
}
