# Conditional Expression
A conditional expression uses the value of a bool expression to select one of two values.

Syntax:

```condition ? true_val : false_val```

## Example
```
provider "aws" {}

variable "istest" {}

resource "aws_instance" "dev" {
    ami = "xyz"
    instance_type = "t2.micro"
    count = var.istest == true ? 1 : 0
}

resource "aws_instance" "prod" {
    ami = "xyz"
    instance_type = "t2.large"
    count = var.istest == false ? 1 : 0
}

```