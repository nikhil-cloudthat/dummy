terraform {
  source = "git::https://@github.com/ONDC-Organization/ondc-infra-modules.git//modules/secrets-manager"

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

dependency "kms" {
 config_path = "../kms"  # Adjust the relative path to your VPC module
}

inputs = {

    environment = include.env.locals.environment_name
    service_names = include.env.locals.service_name
    recovery_window_in_days = 30
    kms_key_id = dependency.kms.outputs.key_id
    description = "microservices secrets"
    
}