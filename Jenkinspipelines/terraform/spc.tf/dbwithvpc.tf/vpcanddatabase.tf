terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "my_virginia_vpc" {
  cidr_block = "192.168.0.0/16"
 
   tags = {
    Name = "new-vpc"
   }
}
resource "aws_subnet" "subnet" {
    availability_zone = "us-east-1b"
  vpc_id     = aws_vpc.my_virginia_vpc.id
  cidr_block = "192.168.0.0/24"

  tags = {
    Name = "Main"
  }
}
resource "aws_subnet" "subnet1" {
    availability_zone = "us-east-1a"
  vpc_id     = aws_vpc.my_virginia_vpc.id
  cidr_block = "192.168.3.0/24"

  tags = {
    Name = "Main2"
  }
}

resource "aws_db_subnet_group" "abc" {
  name       = "main4"
  subnet_ids = [aws_subnet.subnet.id,aws_subnet.subnet1.id]

  tags = {
    Name = "My DB subnet group"
  }
}
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0.28"
  instance_class       = "db.t2.micro"
  username             = "Adnan"
  password          = random_password.password.result
  skip_final_snapshot  = true
  vpc_security_group_ids = [ aws_security_group.allow_tls.id ]
  db_subnet_group_name = "main4"
}