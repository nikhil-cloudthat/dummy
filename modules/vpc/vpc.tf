provider "aws" {
  region  = "ap-south-1" 
  profile = "AWSAdministratorAccess-703671898773"  
}
# VPC
resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "asista-aws-prd-ap-south-1-vpc"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr_public[1]
  map_public_ip_on_launch = true
  availability_zone       = "${var.aws_region}b"
  tags = {
    Name = "asista-aws-prd-ap-south-1-public-subnet2"
  }
}
# Private Subnets
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_private[0]
  availability_zone = "${var.aws_region}a"
  tags = {
    Name = "asista-aws-prd-ap-south-1-private-subnet1"
  }
}
resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_private[1]
  availability_zone = "${var.aws_region}b"
  tags = {
    Name = "asista-aws-prd-ap-south-1-private-subnet2"
  }
}
# NAT Gateway
resource "aws_eip" "nat_eip" {
  tags = {
    Name = "asista-aws-prd-ap-south-1-eip"
  }
}
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id 
  tags = {
    Name = "asista-aws-prd-ap-south-1-nat-gateway"
  }
}
