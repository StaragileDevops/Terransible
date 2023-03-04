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
  access_key = "AKIA5QYQHL5JCIEGPHPG"
  secret_key = "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"
}

#Define Infrastructure
resource "aws_instance" "Terraform_demo_instance"{
	ami = "ami-0557a15b87f6559cf"
	instance_type = "t2.nano"
	tags = {
	Name = "Terraform Instance 1"
}
}
#Define another instance
resource "aws_instance" "Terraform_another"{
	ami = aws_instance.Terraform_demo_instance.ami
	instance_type = "t2.nano"
	tags = {
	Name = "Terrafom another"
}
}
