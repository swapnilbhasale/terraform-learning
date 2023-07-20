provider "aws" {
    region = "us-west-2"
}

resource "aws_security_group" "var_demo" {
  name        = "var_demo"

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [var.vpn_ip]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [var.vpn_ip]
  }

  ingress {
    from_port        = 53
    to_port          = 53
    protocol         = "tcp"
    cidr_blocks      = [var.vpn_ip]
  }
}

resource "aws_instance" "myec2" {
    ami = "ami-00c39f71452c08778"
    instance_type = var.instancetype
}