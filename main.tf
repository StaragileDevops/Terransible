//Security group creation and whitelisting the ip
resource "aws_security_group" "allow_tls" {
  name = "terraform-sg"

  ingress {
    description = "Allow port 22 - inbound"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow port 8080 - inbound"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = "ap-northeast-1"
}
resource "aws_instance" "myec2" {
  ami                    = "ami-0b828c1c5ac3f13ee"
  instance_type          = "t2.micro"
  availability_zone = "ap-northeast-1a"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name = "Jen"
  public_key = "AAAAB3NzaC1yc2EAAAADAQABAAABAQC0M5dm8dWE4Cd37s0i7kbAjYw3Rf/gDMNhzrLXhH+MyQJUcCrDSLHnGg8GDz/AdVcYuPAoCBxAGWJkLhqpn4C/i+9xiuCmQAh4CeA76fBtjACWiwXb/O71bm4/KSWkhzFOmffJs5vmvMD/GFUPSZdLkwa9hPxTAG1WFKNrw2eIUzHI3hbace/FYidVTglo1ls6y/mKYwA2QXlNBEkQCzRSUo+rQblnNG36hQhmLYHEEWFDdK/OE2KfhkL9coNf1mcrccWXtND48F9dqVPW8LKfJ19ZMEwGeMiprNHjVSmzPzJQuLsORART/G02nhDu96TOtGMaZjEua5p8QPzS8HWv"

  tags = {
    name = "testec2"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.myec2.public_ip} >> /etc/ansible/hosts"
  }
}
