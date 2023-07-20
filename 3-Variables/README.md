# Approaches to Variable Assignment

Variables in Terraform can be assigned values in multiple ways.

Some of these include:
1. Environment Variables
2. Command Line Flags
3. From a File
4. Variable Defaults

## Variable Defaults
1. Create a ```variables.tf``` file and add all variables with default values.
2. Use the created variables in other tf files using ```var.<variable_name>``` syntax.
3. If no explicit value is supplied then Terraform will use this default value.

## Command-Line Flag
demo.tf
```
provider "aws" {
    region = "us-west-2"
}

resource "aws_instance" "myec2" {
    ami = ""
    instance_type = var.instancetype
}
```

variables.tf
```
variable "instancetype"{
    default = "t2.medium"
}
```

```
terraform plan -var="instancetype=t2.small"
```

## From a File
1. Create a ```terraform.tfvars``` file and all variables and assignments there.

# Data types for variables

The type argument in a variable block allows you to restrict the type of value that will be accepted as the value of a variable.

```
variable "image_id" {
    type = string
}
```

If no type constraint is set then a value of any type is accepted.

## Type keywords
1. string = sequence of unicode characters representing text like "hello".
2. list = sequential list of vlaues identified by their position. Starts with 0 = ["pune", "mumbai", "delhi"]
3. map = a group of values identified by named labels = {name = "swapnil", age = 30}
4. number = 200

## Fetching Data from Maps and List Variable

### Example
```
provider "aws" {}

resource "aws_instance" "myec2-1" {
    ami = "xyz"
    instance_type = var.types["ap-south-1"]
}

resource "aws_instance" "myec2-2" {
    ami = "xyz"
    instance_type = var.list[1] # this value will be m5.xlarge
}

variable "list" {
    type = list
    default = ["m5.large", m5.xlarge", "t2.medium"]
}

variable "types" {
    type = map
    default = {
        us-east-1 = "t2.micro"
        us-west-2 = "t2.nano"
        ap-south-1 = "t2.small"
    }
}
```
