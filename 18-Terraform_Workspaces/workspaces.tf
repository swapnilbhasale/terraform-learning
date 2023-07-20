provider "aws" {}

resource "aws_instance" "myec2" {
    ami = "ami-0507f77897697c4ba"
    # lookup function retrieves the value of a single element from a map, given its key
    # if the given key does not exist, a default value is returned instead
    # lookup(map, key, default)
    instance_type = lookup(var.instance_type, terraform.workspace)
}

variable "instance_type" {
    type = map

    default = {
        default = "t2.nano"
        dev = "t2.micro"
        prd = "t2.large"
    }
}