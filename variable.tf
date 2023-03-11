variable "region" {
  description = "AWS Deployment region.."
  default     = "eu-west-1"
}

variable "ec2_ami" {
  default = "ami-01cae1550c0adea9c"
}

variable "ec2_instance_type" {
  default = "t2.micro"
}

variable "project_name" {
  default = " CLoud-Website-WV-project"
}

variable "cider_block" {
  default = "10.0.0.0/16"
}

variable "public_subnet_1_cb" {
  default = "10.0.0.0/24"
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "subnets_map" {
  default = {
    subnet1 = {
      name           = "subnet1"
      address_prefix = "10.0.1.0/24"
    }
    subnet2 = {
      name           = "subnet2"
      address_prefix = "10.0.2.0/24"
    }
  }
}

variable "public_subnet_2_cb" {
  default = "10.0.1.0/24"
}

variable "private_subnet_1_cb" {
  default = "10.0.2.0/24"
}

variable "private_subnet_2_cb" {
  default = "10.0.3.0/24"
}

variable "ssh_MyIP" {
  default = "89.247.164.71/32"
}


