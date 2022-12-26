provider "aws" {
  region = var.region
}

resource "aws_instance" "ec2_1" {
  ami                    = var.ec2_ami
  instance_type          = var.ec2_instance_type
  vpc_security_group_ids = [aws_security_group.webserver-security-group.id]
  subnet_id              = aws_subnet.public_subnet_1.id
  user_data              = file("script.sh")
  key_name               = "MyPemFinalKey"
}
resource "aws_instance" "ec2_2" {
  ami                    = var.ec2_ami
  instance_type          = var.ec2_instance_type
  vpc_security_group_ids = [aws_security_group.webserver-security-group.id]
  subnet_id              = aws_subnet.public_subnet_2.id
  user_data              = file("script.sh")
  key_name               = "MyPemFinalKey"
}



#resource "aws_security_group" "elb-security-group" {
#  name        = "elb security group"
#  description = "Enable HTTP/HTTPS access on Port 80/443"
#  vpc_id      = aws_vpc.vpc.id
#
#  ingress {
#    description = "HTTP Access"
#    from_port = 80
#    to_port = 80
#    protocol = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#
#  ingress {
#    description = "HTTPs Access"
#    from_port = 443
#    to_port = 443
#    protocol = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#
#  egress {
#    from_port = to_port          =
#    protocol = cidr_blocks      =
#  }
#
#  tags = {
#    Name =
#  }
#}

#resource "aws_security_group" "database-security-group" {
#  name        =
#  description =
#  vpc_id      =
#
#  ingress {
#description      =
#from_port        =
#to_port          =
#protocol         =
#security_groups  =
#}
#
#egress {
#from_port        =
#to_port          =
#protocol         =
#cidr_blocks      =
#}
#
#tags   = {
#Name =
#}
#}
