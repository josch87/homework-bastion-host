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