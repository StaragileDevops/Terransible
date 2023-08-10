//Security group creation and whitelisting the ip
resource "aws_security_group" "allow_tls" {
  name = "terraform-sg"

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
  key_name = "Jens"
  tags = {
    Name = "test-server"
  }

  provisioner "local-exec" {
    command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root echo ${aws_instance.myec2.public_ip} > /etc/ansible/hosts"
  }
}
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFqn8jb///hPrhWI4JnbfJRl6sWHzfbcEobKta6zk1jcrIIaVhXNSUSlcGi0KkhFoVYAWBw65G9qEDAzYCs+v8Px3HIkiqorcb0oOgguC2PiEw4G//KyNas/J2Q1NZZo+nL8J7Aih7olYt/TrjfZ11GRdH9XtCJQHqbbvYTI9tQIcZJgT22nsYcA9gj7aAXM56wES7TpFPef94PcEHKnkid8PapfngSNJfyWc+GinNGH+YxpxRqL3J6g43LbESA0l/ADALvT1rxRCqK9/bJUd6bR8KoK/zr6p2L06Kpq7jhgM+Be5FkzPATQk0pUmvID3xPq4dG/XtiUCwdhanQJFJ Jens"
}
