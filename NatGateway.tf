resource "aws_eip" "Nat-Gateway-EIP_1" {
  vpc  = true
  tags = {
    Name = "EIP 1"
  }
}
resource "aws_eip" "Nat-Gateway-EIP_2" {
  vpc  = true
  tags = {
    Name = "EIP 2"
  }
}

resource "aws_nat_gateway" "NAT_GATEWAY_1" {
  allocation_id = aws_eip.Nat-Gateway-EIP_1.id
  subnet_id     = aws_subnet.public_subnet_1.id
  tags          = {
    Name = "Nat-Gateway_1_Project"
  }
}
resource "aws_nat_gateway" "NAT_GATEWAY_2" {
  allocation_id = aws_eip.Nat-Gateway-EIP_2.id
  subnet_id     = aws_subnet.public_subnet_2.id
  tags          = {
    Name = "Nat-Gateway_2_Project"
  }
}