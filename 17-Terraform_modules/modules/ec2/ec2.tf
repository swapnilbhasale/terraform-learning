resource "aws_instance" "myec2" {
    ami = "ami-0507f77897697c4ba"
    instance_type = var.instance_type
}