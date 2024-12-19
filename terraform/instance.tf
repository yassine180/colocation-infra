resource "aws_network_interface" "jenkins-server-nic" {
  subnet_id       = aws_subnet.public-subnet.id
  private_ips     = ["10.10.10.100"]
  security_groups = [aws_security_group.jenkins-security-group.id]

  tags = {
    Project = "Colocation"
    Name    = "Jenkins NIC"
  }
}

resource "aws_eip" "jenkins-server-eip" {
  domain            = "vpc"
  depends_on        = [aws_instance.jenkins-server]
  network_interface = aws_network_interface.jenkins-server-nic.id

  tags = {
    Project = "Colocation"
    Name    = "jenkins EIP"
  }
}

resource "aws_instance" "jenkins-server" {
  ami               = "ami-0c7217cdde317cfec"
  instance_type     = "t2.large"
  key_name          = "jenkins-ssh-key"
  availability_zone = "us-east-1a"

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.jenkins-server-nic.id
  }

  tags = {
    Project = "Colocation"
    Name    = "Jenkins Server"
  }
}
