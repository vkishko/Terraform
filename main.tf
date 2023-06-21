terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
  access_key = "AKIAZC6UO2XTXHQJK4XF"
  secret_key = "E+DNkheriyjCzBErasGLuPoAAsmUoiIlqBY73jO5"
}

resource "aws_key_pair" "example" {
  key_name   = "example-keypair"
  public_key = file("~/.ssh/id_rsa.pub")  # Replace with the path to your public key file
}

resource "aws_instance" "example" {
  ami           = "ami-0b2ac948e23c57071"  # Replace with the AMI ID of your desired operating system
  instance_type = "t2.micro"
  key_name      = aws_key_pair.example.key_name  # Replace with the name of your EC2 key pair

  tags = {
    Name = "example-instance"
  }
}

output "instance_ip" {
  value = aws_instance.example.public_ip
}