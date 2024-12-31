# Create Security Group for the Application Load Balancer
resource "aws_security_group" "alb-security-group" {
  name        = "ALB Security Group"
  description = "Enable HTTP/HTTPS access on Port 80/443"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "HTTP Access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS Access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project = "Colocation"
    Name    = "ALB Security Group"
  }
}

# Create Security Group for the jenkins Host aka Jump Box
resource "aws_security_group" "jenkins-security-group" {
  name        = "jenkins Security Group"
  description = "Enable SSH and jenkins access on Ports 22, 8080"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh-location]
  }

  ingress {
    description = "jenkins Access"
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
    Name    = "jenkins Security Group"
  }
}

# Create Security Group for the Web Servers
resource "aws_security_group" "services-security-group" {
  name        = "Web Servers Security Group"
  description = "Enable HTTP/HTTPS Access on Port 80/443 via ALB and All Access for jenkins Host"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description     = "HTTP Access"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-security-group.id]
  }

  ingress {
    description     = "HTTPS Access"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-security-group.id]
  }

  ingress {
    description     = "All Access"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.jenkins-security-group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project = "Colocation"
    Name    = "Web Servers Security Group"
  }
}

# Create Security Group for the Jenkins Server
# resource "aws_security_group" "jenkins-security-group" {
#   name        = "Jenkins Security Group"
#   description = "Enable All Access for jenkins Host"
#   vpc_id      = aws_vpc.vpc.id

#   ingress {
#     description = "Sonar Access"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["10.10.0.0/16"]
#   }

#   ingress {
#     description = "HTTP Access"
#     from_port   = 8080
#     to_port     = 8080
#     protocol    = "tcp"
#     cidr_blocks = ["10.10.0.0/16"]
#   }

#   ingress {
#     description     = "All Access"
#     from_port       = 0
#     to_port         = 0
#     protocol        = "-1"
#     security_groups = [aws_security_group.jenkins-security-group.id]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Project = "Colocation"
#     Name    = "Jenkins Server Security Group"
#   }
# }

# Create Security Group for the SonarQube Server
# resource "aws_security_group" "sonar-security-group" {
#   name        = "SonarQube Security Group"
#   description = "Enable All Access for jenkins Host and Some Accesse for Jenkins"
#   vpc_id      = aws_vpc.vpc.id

#   ingress {
#     description = "HTTP Access"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["10.10.0.0/16"]
#   }

# ingress {
#   description     = "HTTP Access"
#   from_port       = 9000
#   to_port         = 9000
#   protocol        = "tcp"
#   security_groups = [aws_security_group.jenkins-security-group.id]
# }

#   ingress {
#     description = "SonarScanner Access"
#     from_port   = 9001
#     to_port     = 9001
#     protocol    = "tcp"
#     cidr_blocks = ["10.10.0.0/16"]
#   }

#   ingress {
#     description     = "All Access"
#     from_port       = 0
#     to_port         = 0
#     protocol        = "-1"
#     security_groups = [aws_security_group.jenkins-security-group.id]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "SonarQube Server Security Group"
#   }
# }

# # Create Security Group for the Database
# resource "aws_security_group" "database-security-group" {
#   name        = "Database Security Group"
#   description = "Enable MYSQL/Aurora access on Port 3306"
#   vpc_id      = aws_vpc.vpc.id

#   ingress {
#     description     = "MYSQL/Aurora Access"
#     from_port       = 3306
#     to_port         = 3306
#     protocol        = "tcp"
#     security_groups = [aws_security_group.webserver-security-group.id]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "Database Security Group"
#   }
# }
