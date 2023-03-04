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
  public_key = "-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAtDOXZvHVhOAnd+7NIu5GwI2MN0X/4AzDYc6y14R/jMkCVHAq
w0ix5xoPBg8/wHVXGLjwKAgcQBliZC4aqZ+Av4vvcYrgpkAIeAngO+nwbYwAlosF
2/zu9W5uPyklpIcxTpn3ybOb5rzA/xhVD0mXS5MGvYT8UwBtVhSja8NniFMxyN4W
2nHvxWInVU4JaNZbOsv5imMANkF5TQRJEAs0UlKPq0G5ZzRt+oUIZi2BxBFhQ3Sv
zhNin4ZC/XKDX9ZnK3HFl7TQ+PBfXalT1vCynydfWTBMBnjIqazR41Upsz8yULi7
DkQEU/xtNp4Q7vekzrRjGmYxLmuafED80vB1rwIDAQABAoIBAAsAT1DwmKl5Cc/P
m2RziYw91/6T3nAuN0tkVBTGOQc+Sk8fXez4JixGsf4btjeosj2HJNo8zIS5SAF3
sxcB7tlC0MZsxRRBOoMhjzf5Kz1026BVMnFgurHvIPnoKC0oN8FlsvP0bCMlCN9J
+/9n7b2mZzXwxXrHvuUPc36julFfMG0uI9TjwiPIdOmf1zp4/Z1b8AjFwtWiTU3b
h1m50OSxU9gZci5EPbWFccFlDQGuBYoJlakH5L5Y+F7UeUEjKINqVTTiwfOCU5qK
uNcGlV9wq8ngmYEDecSO/bTd7zVnr7neD9oNG8gJd/UdTYp0uUdCHrSDvRiprI3N
LU3HqkECgYEA9BywgxIoYLTP+i8wmn7odReDoarCtWvvYeAYcZ4N24KiP9YU/qep
pMWwyZl9JxyyEPUQOxcnUwmtTGl5o5vO1dEC1W27/4X3wdPZGapScOOVjkE2hctg
GJdUt11BIMar2rbORHGmMv+3hoFdAGYn5qPjvm+KC861kTYGvnaIleECgYEAvPoj
Zy8CBdkvydcsq74WE0nD/8k+rX4LAl1R4fyBHUYLhMi+RnGVJyZsQOvciphVkvlJ
J3JLuz0vGozAf6/IwgIlMFNvlTkcoZPm6slJtVmr1/gF18mGsLWVMP3AVsVcLfnn
y0FguUMKnLSInuoM3VQfibCGsDGHgYio/kByXY8CgYEAu0dzZ+s7TQ4K7S7dA/pP
Dt4OX65pGNSI37cUKb6PdRPgtEbi7ofkz4PXYKM/8AzE09ufKyZVRhCLgq784jc7
1LA4k1NPwvadoHeN/HG+M9t2Np/zW2wu+k7HcLG7sJCa8f4De2ERl9i1jRycJB07
iWe85rId33cjtxcSz3aSzSECgYEAlj+iqkU7rH6zehz0TVACqS87AEF27eWKx0R+
99gUp7urKNWaQtPHrKrl4vAkFqVrVEGTIiPDhojszIUf/+U5Dtc5ziRoURJpayX2
sLF9QwyajkmKC7kUt6aHib4WkGa2FW/eFUJTrrhY1aLMBN09gTODJ6wMSkX24MxQ
4GVJCI0CgYA4Od7c+AH6dPUEwnP5lxhhn/IMZSD9hcZJK7Gw4OolBLV/5mzFAHQE
y9NWU6RDchDirxlUHTUAL/SPoNHtkIl6aKa5JvzdnOLaVpWvOJT1Nik6bU0d3HEC
toi94jK8OH2drv6LAU8GAbOPL435LmTrW6ftDVkGE467x9HryCfwpw==
-----END RSA PRIVATE KEY-----
"

  tags = {
    name = "testec2"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.myec2.public_ip} >> /etc/ansible/hosts"
  }
}
