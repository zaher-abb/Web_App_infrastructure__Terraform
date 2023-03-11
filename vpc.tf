resource "aws_vpc" "vpc" {
  cidr_block           = var.cider_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "vpc for ${var.project_name}"
  }
}
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "vpc-Gateway for ${var.project_name}"
  }
}
# use data source to get all availability zones in region
data "aws_availability_zones" "available_zones" {}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnets[0]
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "public subnet_1"
  }
}
resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_2_cb
  availability_zone = data.aws_availability_zones.available_zones.names[1]

  map_public_ip_on_launch = true
  tags = {
    Name = "public subnet_2"
  }
}
resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_1_cb
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = false
  tags = {
    Name = "private subnet_1"
  }
}
resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_2_cb
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = false
  tags = {
    Name = "private subnet_2"
  }
}
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

resource "aws_route_table_association" "public_subnet_1_rt_associate_public" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_2_rt_associate_public" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_subnet_1_rt_associate_public" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table_1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT_GATEWAY_1.id
  }
  tags = {
    Name = "private_route_table 1"
  }
}

resource "aws_route_table" "private_route_table_2" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT_GATEWAY_2.id
  }
  tags = {
    Name = "private_route_table 2"
  }
}
resource "aws_route_table_association" "private_subnet_2_rt_associate_public" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table_1.id
}



resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}