output "jenkins-ip" {
  value = aws_eip.jenkins-server-eip.public_ip
}
