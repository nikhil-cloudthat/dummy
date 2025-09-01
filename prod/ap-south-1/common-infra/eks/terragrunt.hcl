terraform {
  source = "git::https://@github.com/AWS-CICD-ASISTA/asista-infra-modules.git//eks?ref=prod"
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

    cluster_name                         = "eks"
    cluster_version                      = "1.32"

    vpc_id                               = include.env.locals.vpc_id
    subnet_ids                           = [include.env.locals.eks_controlplane_subnet_az1,include.env.locals.eks_controlplane_subnet_az2]
    control_plane_subnet_ids             = [include.env.locals.eks_controlplane_subnet_az1,include.env.locals.eks_controlplane_subnet_az2]
    vpc_cidr                             = [include.env.locals.vpc_cidr]

    eks_managed_node_groups = {
      asista-frontend-nodes = {
        name  = "asista-frontend-nodes"
        instance_types = ["t3a.large"]
        ami_type       = "AL2_x86_64"
        min_size     = 2
        max_size     = 3
        desired_size = 2

        iam_role_additional_policies = {
          AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
          AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
        }

        block_device_mappings = {
          xvda = {
            device_name = "/dev/xvda"
            ebs = {
              volume_size           = 20
              volume_type           = "gp3"
              delete_on_termination = true
              encrypted             = true
            }
          }
        }
      }


      asista-frontend-nodes-2 = {
        name  = "asista-frontend-nodes"
        instance_types = ["t3a.large"]
        ami_type       = "AL2_x86_64"
        min_size     = 2
        max_size     = 3
        desired_size = 2

        iam_role_additional_policies = {
          AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
          AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
        }

        block_device_mappings = {
          xvda = {
            device_name = "/dev/xvda"
            ebs = {
              volume_size           = 20
              volume_type           = "gp3"
              delete_on_termination = true
              encrypted             = true
            }
          }
        }
      }

      asista-common-nodes = {
        name    = "asista-common-nodes"
        instance_types = ["c5a.2xlarge"]
        ami_type       = "AL2_x86_64"
        min_size     = 2
        max_size     = 3
        desired_size = 2

        iam_role_additional_policies = {
          AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
          AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
        }

        block_device_mappings = {
          xvda = {
            device_name = "/dev/xvda"
            ebs = {
              volume_size           = 20
              volume_type           = "gp3"
              delete_on_termination = true
              encrypted             = true
            }
          }
        }
      }

      asista-backend-nodes = {
        instance_types = ["t3a.xlarge"]
        ami_type       = "AL2_x86_64"
        min_size       = 2
        max_size       = 3
        desired_size   = 2


        iam_role_additional_policies = {
          AmazonSSMManagedInstanceCore  = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
          AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
        }

        block_device_mappings = {
          xvda = {
            device_name = "/dev/xvda"
            ebs = {
              volume_size           = 20
              volume_type           = "gp3"
              delete_on_termination = true
              encrypted             = true
            }
          }
        }
      }

    }

    service_name = "eks"
    team_name    = "DevOps"
    environment  = include.env.locals.environment_name
    launched_by  = "terraform"
    project_name = "asista"