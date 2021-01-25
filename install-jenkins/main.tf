terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

#Configure the AWS provider
provider "aws" {
  region     = var.region
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners        = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name = var.instance_name
  }
}

resource "aws_security_group" "security_group_jenkins_antonio" {
  name = "security_group_jenkins_antonio"

  ingress {
    description = "SSH from Instance"
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  
  ingress {
    description = "Jenkins from Instance"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
  }

  ingress {
    description = "Web Server from Instance"
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "security_group_jenkins_antonio"
  }
}
