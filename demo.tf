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
  region = "ap-northeast-1"
  
}

#Define Infrastructure
resource "aws_instance" "terraform"{
	ami = "ami-0b828c1c5ac3f13ee"
	instance_type = "t2.micro"
	tags = {
	Name = "Terraform Instance 1"
}
provisioner "local-exec" {
    command = "echo ${aws_instance.terraform.public_ip} > /etc/ansible/hosts"
}
}

