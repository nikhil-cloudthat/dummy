terraform {
  source = "git::https://@github.com/ONDC-Organization/ondc-infra-modules.git//modules/tgw/tgw-attachment"
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
  env        = "pre-prod"  
  vpc_id     = "vpc-0198d151c2de50431"  
  subnet_ids = ["subnet-0fa57793894057de5"] 
  tgw_id     = "tgw-0353114d36a01c0d3" 
}