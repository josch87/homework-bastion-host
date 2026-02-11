resource "aws_vpc" "homework_vpc" {
  cidr_block = "10.0.0.0/24"
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