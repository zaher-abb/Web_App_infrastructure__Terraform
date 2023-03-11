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
