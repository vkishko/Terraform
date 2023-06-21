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
  public_key = file("ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC3uPBcs3WH+GalbWR98K6dGSI7SloFYDCCwTCjITCrfWHORNm0A+eNvSNBH+bpr39UvZTxg3rBfdqhAcJDxcWOC6WyXuyFVrROzgkCstgOAz8NnNztqq1vbb59PgTsyC6c3iaY3cCwgzpgKCgV9P7Z/MAC2b5g9KF82yGJzIvlXrdFBCQNqMSJvKlNJ9ujDKsLq67FDpMqKNNgih8tuX207k8Y4zen3UIS0Sos4v8MLeQYxW7a8DOwfNOdfyziwkMA/2Xzpqcmrk0S/JvdBiQ5+gQzQQsGtOFRSdG3fCI5nxjXmlbay1mwADzwoc6y+Gk/Rx4/kLqujP6kjWqg1PphM+BuuIXzffX+zyQ2NDhgwu/u9OaTEiMH3GRVv8MLHx+325g4ZjCvCEQqqqUZjXy5yJP4shkNDKAiXkDCl6LoodBIVUJsHpNNihXT2UEoacX/Pkpf3VOoWT2Jgma6hMmMmhnqlflxhVPjiT1X6P1EHJ3cuAnMwcCZppmeFw89gYc= grishko@MacBook-Pro-Admin.local")  # Replace with the path to your public key file
 #public_key = file("~/.ssh/id_rsa.pub")
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