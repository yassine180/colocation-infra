output "jenkins-ip" {
  value = aws_eip.jenkins-server-eip.public_ip
}

# output "jenkins-ip" {
#   value = aws_network_interface.jenkins-server-nic.private_ip
# }

# output "sonar-ip" {
#   value = aws_network_interface.sonar-server-nic.private_ip
# }
