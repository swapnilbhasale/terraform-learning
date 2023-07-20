/*
If the value of istest is true, then the dev instance will be created
If the value of intest is false, then the prod instance will be created
We can specify the count for the number of instances that are needed
The value of istest is declared in terraform.tfvars
*/

provider "aws" {}

variable "istest" {}

resource "aws_instance" "dev" {
  ami           = "xyz"
  instance_type = "t2.micro"
  count         = var.istest == true ? 1 : 0
}

resource "aws_instance" "prod" {
  ami           = "xyz"
  instance_type = "t2.large"
  count         = var.istest == false ? 1 : 0
}