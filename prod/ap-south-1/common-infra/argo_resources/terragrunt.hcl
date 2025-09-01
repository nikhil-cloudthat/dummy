terraform {
  source = "git::https://@github.com/ONDC-Organization/ondc-infra-modules.git//modules/eks-resources"
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

dependency "eks" {
  config_path = "../eks"
  mock_outputs = {eks_cluster_name = "eks_cluster_name", eks_cluster_certificate_authority_data = "eks_cluster_certificate_authority_data", eks_cluster_endpoint = "eks_cluster_endpoint" }
}

dependency "vpc" {
  config_path = "../vpc"
}


inputs = {
  # JenkinsTerraformDeploymentAdminRole  = include.env.locals.JenkinsTerraformDeploymentAdminRole
  eks_cluster_endpoint = dependency.eks.outputs.eks_cluster_endpoint
  # eks_cluster_certificate_authority_data = dependency.eks.outputs.eks_cluster_certificate_authority_data
  cluster_name = dependency.eks.outputs.eks_cluster_name
  argo_parent_app = "argo_crds_root_app"
  # acm_certificate_arn = include.env.locals.acm_certificate_arn
  env = include.env.locals.environment_name 
  subnet_ids = [dependency.vpc.outputs.private_subnet_ids[0],dependency.vpc.outputs.private_subnet_ids[1]]
}