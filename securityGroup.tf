
resource "aws_security_group" "webserver-security-group" {
  name        = "security_group"
  description = "Allow SSH,HTTP,HTTPS inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "SSH from My IP to VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_MyIP]
  }
  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

# Create Security Group for the Application Load Balancer
# terraform aws create security group
resource "aws_security_group" "elb-security-group" {
  name        = "ELB Security Group"
  description = "Enable HTTP/HTTPS access on Port 80/443"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "HTTP Access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"] # hier soll mein IP addresse geschrieben werden
  }
  ingress {
    description = "HTTPS Access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ALB Security Group"
  }
}


resource "aws_security_group" "database-security-group" {
  name        = "Database Security Group"
  description = "Enable MYSQL/Aurora access on Port 3306"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description     = "MYSQL/Aurora Access"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = aws_security_group.webserver-security-group.id
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Database Security Group"
  }
}