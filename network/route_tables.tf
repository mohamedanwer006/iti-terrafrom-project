# ----------------- create routes ---------------

resource "aws_default_route_table" "public" {
  default_route_table_id = aws_vpc.iti_vpc.default_route_table_id

  tags = {
    Name = "iti-default-route-public"
  }
}


resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_default_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.iti_igw.id

  timeouts {
    create = "5m"
  }

}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.iti_public_subnet1.id
  route_table_id = aws_default_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.iti_public_subnet2.id
  route_table_id = aws_default_route_table.public.id
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.iti_vpc.id

  tags = {
    Name = "iti-route-private"
  }
}


resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.iti_private_subnet1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.iti_private_subnet2.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.iti-ngw.id

  timeouts {
    create = "5m"
  }
}



