module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.6.0"
}
resource "aws_instance" "blue" {
  ami                         = "ami-0aa2b7722dc1b5612"
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  key_name                    = "newkey02"
  vpc_security_group_ids      = [aws_security_group.allowalltraffic.id]
  subnet_id                   = aws_subnet.subnet.id

  tags = {
    Name = "blue"
  }
}

resource "aws_instance" "green" {
  ami                         = "ami-0aa2b7722dc1b5612"
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  key_name                    = "newkey02"
  vpc_security_group_ids      = [aws_security_group.allowalltraffic.id]
  subnet_id                   = aws_subnet.subnet.id


  tags = {
    Name = "green"
  }
}

resource "aws_lb_target_group" "green" {
  name     = "green-tg-my-alb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_virginia_vpc.id

  health_check {
    port     = 80
    protocol = "HTTP"
    timeout  = 5
    interval = 10
  }
}

resource "aws_lb_target_group_attachment" "green" {
  count            = length(aws_instance.green)
  target_group_arn = aws_lb_target_group.green.arn
  target_id        = element(aws_instance.green.*.id, 0)

  port = 80
}
resource "aws_lb" "green" {
  name               = "green-lb"
  internal           = false
  load_balancer_type = "application"

  subnet_mapping {
    subnet_id = "subnet-0cc4579161585de88"
  }

  subnet_mapping {
    subnet_id = "subnet-05953305932b9b887"
  } 

  tags = {
    Environment = "production"
  }
}


resource "aws_lb_listener" "frontend_https" {
  load_balancer_arn = aws_lb.green.arn
  port              = 443
  protocol          = "HTTPS"

  certificate_arn = var.https_listeners[0]["certificate_arn"]
  ssl_policy      = var.https_listeners[0]["ssl_policy"]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.green.arn
  }
}




