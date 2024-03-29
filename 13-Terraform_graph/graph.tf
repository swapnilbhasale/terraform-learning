/*
Command:
terraform graph > graph.dot

Install the open source Graphviz tool - brew install graphviz

Convert .dot file to .svg image file
cat graph.dot | dot -Tsvg > graph.svg
*/
provider "aws" {}

resource "aws_instance" "myec2" {
    ami = "ami-082b5a644766e0e6f"
    instance_type = "t2.micro"
}

resource "aws_eip" "lb" {
    instance = aws_instance.myec2.id
    vpc = true
}

resource "aws_security_group" "allow_tls" {
    name = "allow_tls"

    ingress {
        description = "TLS from VPC"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cider_blocks = ["${aws_eip.lb.private_ip}/32"]
    }
}