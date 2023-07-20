# Count Parameter

The count parameter on resources can simplify configurations and let you scale resources by simply incrementing a number.

With the count parameter, we can simply specify the count value and the resource can be scaled accordingly.

## Example
```
resource "aws_instance" "instance-1" {
    ami = "xyz"
    instance_type = "t2.micro"
    count = 5
}
```

# Count Index
In the reosurce blocks where count is set, an additional count object is avaialble in expressions, so you can modify the configuration of each instance.

This object has an attribute:

count.index - The distinct index number (starting with 0) corresponding to this instance.

## Underatnding the challenge with count
With the below code, terraform will create 5 IAM users. But the problem is that all will have the same name - this may not be desirable or may even give an error.

```
resource "aws_iam_user" "lb" {
    name = "loadbalancer"
    count = 5
    path = "/system/"
}
```

count.index allows us to fetch the index of each iteration in the loop.

```
resource "aws_iam_user" "lb" {
    name = "loadbalancer.${count.index}"
    count = 5
    path = "/system/"
}
```

## Understanding challenge with Default Count Index
Having a username like loadbalancer.0, loadbalancer.1 may not be suitable. Better names like dev-loadbalancer, stage-loadbalancer, prod-loadbalancer is better.

count.index can help in such scenarios as well.

```
provider "aws" {}

resource "aws_iam_user" "lb" {
    name = var.elb_names[count.index]
    count = 3
    path = "/system/"
} 

variable "elb_names" {
    type = list
    default = ["dev-loadbalancer", "stage-loadbalancer", "prod-loadbalancer"]
}
```
Do a count.index on elb_names to use the values from the list.