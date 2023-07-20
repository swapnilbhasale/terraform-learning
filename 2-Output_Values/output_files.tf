# Use case-
# Create a Elastic IP (Public IP) resource in AWS and output the value of the EIP.

provider "aws" {
    region = "us-west-2"
}

resource "aws_eip" "lb" {
    domain = "vpc"
}

output "public-ip" {
    # this value will return the public_ip attribute
    value = "https://${aws_eip.lb.public_ip}:8080"
    
    # this value will return all attributes for resource
    #value = aws_eip.lb
}