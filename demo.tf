
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

# Creating a Security Group
resource "aws_security_group" "proj-sg" {
 name = "proj-sg"
 description = "Enable web traffic for the project"
 vpc_id = aws_vpc.proj-vpc.id
 ingress {
 description = "HTTPS traffic"
 from_port = 443
 to_port = 443
 protocol = "tcp"
 cidr_blocks = ["0.0.0.0/0"]
 }
ingress {
 description = "HTTP traffic"
 from_port = 0
 to_port = 65000
 protocol = "tcp"
 cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
 description = "SSH port"
 from_port = 22
 to_port = 22
 protocol = "tcp"
 cidr_blocks = ["0.0.0.0/0"]
 }
 egress {
 from_port = 0
 to_port = 0
 protocol = "-1"
 cidr_blocks = ["0.0.0.0/0"]
 ipv6_cidr_blocks = ["::/0"]
 }
 tags = {
 Name = "proj-sg1"
 }
}

#Define Infrastructure
resource "aws_instance" "terraform"{
	ami = "ami-0b828c1c5ac3f13ee"
	instance_type = "t2.micro"
	tags = {
	Name = "Terraform Instance 1"
}
provisioner "local-exec" {
    command = "echo ${aws_instance.terraform.public_ip} >> /etc/ansible/hosts"
}
}

