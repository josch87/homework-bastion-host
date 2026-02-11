resource "aws_vpc" "homework_vpc" {
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "Homework VPC"
  }
}

resource "aws_subnet" "homework_public_subnet" {
  vpc_id     = aws_vpc.homework_vpc.id
  cidr_block = "10.0.0.0/28"

  tags = {
    Name = "Homework Public Subnet"
  }
}

resource "aws_subnet" "homework_private_subnet" {
  vpc_id     = aws_vpc.homework_vpc.id
  cidr_block = "10.0.0.16/28"

  tags = {
    Name = "Homework Private Subnet"
  }
}

resource "aws_internet_gateway" "homework_ig" {
  vpc_id = aws_vpc.homework_vpc.id

  tags = {
    Name = "Homework IG"
  }
}

resource "aws_route_table" "homework_public_rtb" {
  vpc_id = aws_vpc.homework_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.homework_ig.id
  }

  tags = {
    Name = "Homework Public RTB"
  }
}

resource "aws_route_table_association" "public_rtb_association" {
  subnet_id      = aws_subnet.homework_public_subnet.id
  route_table_id = aws_route_table.homework_public_rtb.id
}

resource "aws_eip" "nat_gateway_eip" {
  domain = "vpc"

  tags = {
    Name = "Homework NAT gw EIP"
  }
}

resource "aws_nat_gateway" "homework_nat_gateway" {
  allocation_id     = aws_eip.nat_gateway_eip.id
  subnet_id         = aws_subnet.homework_public_subnet.id
  connectivity_type = "public"

  tags = {
    Name = "Homework NAT gw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.homework_ig]
}

resource "aws_route_table" "homework_private_rtb" {
  vpc_id = aws_vpc.homework_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.homework_nat_gateway.id
  }

  tags = {
    Name = "Homework Private RTB"
  }
}

resource "aws_route_table_association" "private_rtb_association" {
  subnet_id      = aws_subnet.homework_private_subnet.id
  route_table_id = aws_route_table.homework_private_rtb.id
}