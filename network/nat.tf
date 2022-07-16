
resource "aws_eip" "nat_ip" {
  vpc = true

  tags = {
    Name = "iti-eip"
  }
}

resource "aws_nat_gateway" "iti-ngw" {
  allocation_id = aws_eip.nat_ip.id
  subnet_id     = aws_subnet.iti_public_subnet1.id

  tags = {
    Name = "iti-nat-gw"
  }
}
