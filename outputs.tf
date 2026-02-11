output "bastion_host_public_ip" {
  value       = aws_instance.bastion_host.public_ip
  description = "Public IP address of the bastion host"
}

output "webserver_private_ip" {
  value       = aws_instance.webserver.private_ip
  description = "Private IP address of the webserver"
}