
#-------------------- create vpc ---------------------------

resource "aws_vpc" "iti_vpc" {

  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    "Name" = "iti-vpc"
  }
}
