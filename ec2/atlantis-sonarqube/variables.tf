variable "instance_type" {
  description = "Instance type for Jenkins server"
  type        = string
  default     = "t3a.medium"
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
  default     = ""  # Replace with your actual subnet ID
}


variable "security_group_ids" {
  description = "Security Group IDs for Jenkins servers"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for Jenkins server"
  type        = string
  default     = "ami-08bf489a05e916bbd"  # Replace with your AMI ID
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}
