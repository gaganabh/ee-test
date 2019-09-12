variable "aws_region" {
  description = "Region for the VPC"
  default = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "172.20.0.0/16"
}

variable "ee-public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default = "172.20.10.0/24"
}

variable "ee-private_subnet_cidr" {
  description = "CIDR for the private subnet"
  default = "172.20.20.0/24"
}

variable "ami" {
  description = "centos-ami"
  default = "ami-0009e88f05cf1087c"
}

