resource "aws_instance" "bastion_host" {
  ami                         = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type               = "t3.small"
  key_name                    = "vockey"
  subnet_id                   = aws_subnet.homework_public_subnet.id
  vpc_security_group_ids      = [aws_security_group.bastion_host_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "Bastion Host"
  }
}

resource "aws_instance" "webserver" {
  ami                    = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type          = "t3.small"
  key_name               = "vockey"
  subnet_id              = aws_subnet.homework_private_subnet.id
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  user_data              = file("install-webserver.sh")

  tags = {
    Name = "Webserver"
  }
}