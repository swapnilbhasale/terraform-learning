/*
Splat expression allows us to get a list of all attributes
*/

provider "aws" {

}

resource "aws_iam_user" "lb" {
    name = "iamuser.${count.index}"
    count = 3
    path = "/system/"
}

output "arns" {
    value = aws_iam_user.lb[*].arn
}