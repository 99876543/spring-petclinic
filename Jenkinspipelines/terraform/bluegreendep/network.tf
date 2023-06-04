
resource "aws_vpc" "my_virginia_vpc" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "new-vpc"
  }
}
resource "aws_subnet" "subnet" {
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.my_virginia_vpc.id
  cidr_block        = "192.168.0.0/24"

  tags = {
    Name = "Main"
  }
}
resource "aws_subnet" "subnet2" {
  availability_zone = "us-east-1b"
  vpc_id            = aws_vpc.my_virginia_vpc.id
  cidr_block        = "192.168.1.0/24"

  tags = {
    Name = "Main2"
  }
}

resource "aws_security_group" "allowalltraffic" {
  name        = "all traffic"
  description = "Allow all traffic"
  vpc_id      = aws_vpc.my_virginia_vpc.id

  ingress {
    description      = "open all ports"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "alltraffic"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_virginia_vpc.id

  tags = {
    Name = "my-igw"
  }
}
resource "aws_route_table" "example" {
  vpc_id = aws_vpc.my_virginia_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }


  tags = {
    Name = "example"
  }
}

resource "aws_route_table_association" "route" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.example.id
}