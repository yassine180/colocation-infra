# Allocate Elastic IP Address
resource "aws_eip" "eip-for-nat-gateway" {
  domain = "vpc"

  tags = {
    Project = "Colocation"
    Name    = "Nat Gateway EIP"
  }
}

# Create Nat Gateway in Public Subnet
resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.eip-for-nat-gateway.id
  subnet_id     = aws_subnet.public-subnet.id

  tags = {
    Project = "Colocation"
    Name    = "Public Subnet Nat Gateway"
  }
}

# Create Private Route Table and Add Route Through Nat Gateway
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gateway.id
  }

  route {
    cidr_block           = "10.8.0.0/24"
    network_interface_id = aws_network_interface.jenkins-server-nic.id
  }

  tags = {
    Project = "Colocation"
    Name    = "Private Route Table"
  }
}

# Associate Private Subnet 1 with "Private Route Table"
resource "aws_route_table_association" "private-subnet-1-route-table-association" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-route-table.id
}

# Associate Private Subnet 2 with "Private Route Table"
resource "aws_route_table_association" "private-subnet-2-route-table-association" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private-route-table.id
}

# Associate Private Subnet 3 with "Private Route Table"
resource "aws_route_table_association" "private-subnet-3-route-table-association" {
  subnet_id      = aws_subnet.private-subnet-3.id
  route_table_id = aws_route_table.private-route-table.id
}
