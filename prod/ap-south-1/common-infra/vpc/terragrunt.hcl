terraform {
  source = "git::https://@github.com/ASISTA-Organization/asista-infra-modules.git//modules/vpc"
}


include "root" {
  path = find_in_parent_folders()
}

include "env"{
  path = find_in_parent_folders("env.hcl")
  expose         = true
  merge_strategy = "no_merge"
}
 
 
 
include "account"{
  path = find_in_parent_folders("account.hcl")
  expose         = true
  merge_strategy = "no_merge"
}

inputs = {
  vpc_cidr                             = include.env.locals.vpc_cidr_block
  enable_dns_hostnames                 = true
  cidr_public_subnet_block             = [include.env.locals.cidr_public_subnet_block_1,include.env.locals.cidr_public_subnet_block_2]
  cidr_private_subnet_block            = [include.env.locals.cidr_private_subnet_block_1,include.env.locals.cidr_private_subnet_block_2]
  cidr_private_subnet_data_store_block = [include.env.locals.cidr_private_subnet_data_store_block_1,include.env.locals.cidr_private_subnet_data_store_block_2]
  cidr_transit_gw_subnet_block         = [include.env.locals.cidr_transit_gw_subnet_block]
  region                               = ["ap-south-1b", "ap-south-1a"]  
  env                                  = "prod"
  description                          = "Terraform generated VPC for prod environment"
}
