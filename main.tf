provider "aws" {
  region = var.region
}
resource "aws_instance" "test" {
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.cider_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "vpc for" + var.project_name
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "vpc-Gateway for" + var.project_name
  }
}
# use data source to get all availability zones in region
data "aws_availability_zones" "available_zones" {}

resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnet_1_cb
  availability_zone = data.aws_availability_zones.available_zones.names[1]

  tags = {
    Name = "subnet_1"
  }
}
resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_subnet_2_cb
  availability_zone = data.aws_availability_zones.available_zones.names[1]

  tags = {
    Name = "subnet_1"
  }
}

