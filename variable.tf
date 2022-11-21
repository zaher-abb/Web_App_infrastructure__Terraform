variable "region" {
  description = "AWS Deployment region.."
  default = "us-east-1"
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
variable "private_subnet_2_cb" {
  default = "10.0.0.1/24"
}