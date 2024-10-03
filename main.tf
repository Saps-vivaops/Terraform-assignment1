provider "aws" {
  region     = "ap-south-1"  # or your preferred region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

variable "aws_access_key" {}
variable "aws_secret_key" {}

resource "aws_instance" "my_ec2" {
  ami           = "ami-08718895af4dfa033"
  instance_type = "t2.micro"  # Free-tier eligible

  tags = {
    Name = "MyFirstTerraformEC2"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami           = "ami-08718895af4dfa033" 
  instance_type = "t2.micro"

  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = "TerraformWebServer"
  }
}
