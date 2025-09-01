locals {
  environment_name = ""
  project_name = ""
  region = "ap-south-1"
  # VPC Configuration
  vpc_cidr_block    = "10.2.0.0/16"

  cidr_public_subnet_block_1 = "10.2.0.0/22"
  cidr_public_subnet_block_2 = "10.2.4.0/22"
  cidr_public_subnet_block_3 = "10.2.8.0/22"

  cidr_private_subnet_block_1 = "10.2.12.0/22"
  cidr_private_subnet_block_2 = "10.2.16.0/22"
  cidr_private_subnet_block_3 = "10.2.20.0/22"

  cidr_private_subnet_data_store_block_1 = "10.2.24.0/22"
  cidr_private_subnet_data_store_block_2 = "10.2.28.0/22"
  cidr_private_subnet_data_store_block_3 = "10.2.32.0/22"

  
  cidr_transit_gw_subnet_block = "10.2.36.0/28"

  vpc_id = "vpc-"
  

  # ubuntu 22.04 ami id
  ami_id = "ami-"
  efs_sg = "sg-"
  eks_sg = "sg-"
  mongo_db_sg ="sg-"
  efs_mount_target_sg = "sg-"
  jump_server_sg = "sg-"

  # Database Subnet IDs
  db_subnet_az1 = "subnet-"
  db_subnet_az2 = "subnet-"
  db_subnet_az3 = "subnet-"
  
  #microservices
  service_name = [""]
}