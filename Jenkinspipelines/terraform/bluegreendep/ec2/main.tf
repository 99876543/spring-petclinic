resource "aws_instance" "blue" {
  ami = "ami-007855ac798b5175e"
  associate_public_ip_address = true
  instance_type = "t2.micro"
  key_name = "newkey02"
  vpc_security_group_ids = [aws_security_group.allowalltraffic.id]
  subnet_id = aws_subnet.subnet.id

  tags = {
    Name = "blue"
  }
}
  
resource "aws_instance" "green" {
  ami = "ami-007855ac798b5175e"
  associate_public_ip_address = true
  instance_type = "t2.micro"
  key_name = "newkey02"
  vpc_security_group_ids = [aws_security_group.allowalltraffic.id]
  subnet_id = aws_subnet.subnet.id
  user_data = file("apache.sh")

  tags = {
    Name = "green"
  }
}



