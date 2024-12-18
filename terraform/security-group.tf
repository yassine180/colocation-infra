# Create Security Group for the Jenkins Server
resource "aws_security_group" "jenkins-security-group" {
  name        = "Jenkins Security Group"
  description = "Enable SSH and Jenkins dashboard access on Ports 22, 8080"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh-location]
  }

  ingress {
    description = "Jenkins Access"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.ssh-location]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project = "Colocation"
    Name    = "Jenkins Security Group"
  }
}
