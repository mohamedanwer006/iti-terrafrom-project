# ------------------- create  igw -------------------------

resource "aws_internet_gateway" "iti_igw" {
  vpc_id = aws_vpc.iti_vpc.id

  tags = {
    Name = "iti_igw"
  }
}

