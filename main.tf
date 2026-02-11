terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.31.0"
    }
  }

  required_version = ">=1.2"
}

provider "aws" {
  region = "us-west-2"
  profile = var.profile
}

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

