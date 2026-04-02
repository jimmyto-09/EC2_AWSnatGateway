# Create a VPC
resource "aws_vpc" "red_vpc" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "red_vpc"
  }
}

#create a public subnet
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.red_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "public"
  }
}

#create a private subnet
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.red_vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "private"
  }
}

#create an internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.red_vpc.id

  tags = {
    Name = "gw"
  }
}

#create a ip elastic for nat gateway
resource "aws_eip" "nat_eip" {
  domain   = "vpc"

 tags = {
    Name = "nat_eip"
  }
}


#create a nat gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public.id
  depends_on = [aws_internet_gateway.gw]

  tags = {
    Name = "nat_gw"
  }
}

#Create a route table public
resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.red_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
 tags = {
    Name = "route_table_public"
  }
}

#Associate the route table with the public subnet
resource "aws_route_table_association" "route_table_association_public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.route_table_public.id
}

#Create a route table private
resource "aws_route_table" "route_table_private" {
  vpc_id = aws_vpc.red_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
 tags = {
    Name = "route_table_private"
  }
}

#Associate the route table with the private subnet
resource "aws_route_table_association" "route_table_association_private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.route_table_private.id
}

