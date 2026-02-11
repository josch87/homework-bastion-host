resource "aws_instance" "bastion_host" {
  ami           = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type = "t3.small"
  key_name      = "vockey"
  subnet_id     = aws_subnet.homework_public_subnet.id

  tags = {
    Name = "Bastion Host"
  }
}