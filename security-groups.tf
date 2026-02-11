resource "aws_security_group" "bastion_host_sg" {
  name        = "Bastion Host SG"
  description = "Allow SSH for developers"
  vpc_id      = aws_vpc.homework_vpc.id

  tags = {
    Name = "Bastion Host SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "bastion_host_sg_ingress_allow_ssh" {
  security_group_id = aws_security_group.bastion_host_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "bastion_host_sg_egress_allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.bastion_host_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_security_group" "webserver_sg" {
  name        = "Webserver SG"
  description = "Allow SSH from bastion host and HTTP from public"
  vpc_id      = aws_vpc.homework_vpc.id

  tags = {
    Name = "Webserver SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "webserver_sg_ingress_allow_ssh_from_bastion_host" {
  security_group_id            = aws_security_group.webserver_sg.id
  referenced_security_group_id = aws_security_group.bastion_host_sg.id

  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "webserver_sg_ingress_allow_http" {
  security_group_id = aws_security_group.webserver_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "webserver_sg_egress_allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.webserver_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}