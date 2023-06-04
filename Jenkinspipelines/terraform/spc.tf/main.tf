terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.62.0"
    }
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0aa2b7722dc1b5612"
  instance_type = "t2.micro"

  tags = {
    Name = "web-server"
  }

  provisioner "local-exec" {
    command = "echo '${aws_instance.web.private_ip}' > inventory"
  }
}

resource "local_file" "ansible_inventory" {
  content  = <<ADA
[web]
${aws_instance.web.private_ip}
ADA

  filename = "inventory"
}

resource "null_resource" "ansible" {
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("./Downloads/newkey02.pem")
    host        = aws_instance.web.private_ip
  }
  

  provisioner "local-exec" {
    command = "ansible-playbook -i inventory playbook.yml"
  }
}
resource "null_resource" "install_spring_petclinic" {
  provisioner "local-exec" {
    command = "curl https://raw.githubusercontent.com/spring-projects/spring-petclinic/main/setup.sh | bash"
  }
}