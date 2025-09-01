generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "aws" {
 region  = "AWS_REGION"
 #profile = "default"
  
assume_role {
    session_name = "terraform"
    role_arn = "arn:aws:iam::ACCOUNT_ID:role/terraform-assumed-role-shared"
  }
}

EOF
}

  

remote_state {
  backend = "s3"
  generate = {
    path      = "state.tf"
    if_exists = "overwrite_terragrunt"
  }

config = {
# profile = "default"
    role_arn = "arn:aws:iam::AWS_ACCOUNT_ID:role/terraform-assumed-role-shared"
    bucket = "terraform-ppd-state"

    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-ppd-lock-table"
  }
}


