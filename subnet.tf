
#-------------------- create vpc ---------------------------

resource "aws_vpc" "iti_vpc" {

  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    "Name" = "iti-vpc"
  }
}

# ----------------- create public subnet  az1 ---------------

resource "aws_subnet" "iti_public_subnet1" {
  vpc_id            = aws_vpc.iti_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Public subnet"
  }
}


# ----------------- create public subnet az2 ---------------

resource "aws_subnet" "iti_public_subnet2" {
  vpc_id            = aws_vpc.iti_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "Public subnet"
  }
}

# ----------------- create private subnet  az1 ---------------

resource "aws_subnet" "iti_private_subnet1" {
  vpc_id            = aws_vpc.iti_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Public subnet"
  }
}

# ----------------- create private subnet az2 ---------------

resource "aws_subnet" "iti_private_subnet2" {
  vpc_id            = aws_vpc.iti_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "Public subnet"
  }
}
