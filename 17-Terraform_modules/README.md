# DRY principle

1. Don't Repeat Yourself - reduce repetition of software patterns.

# Using Locals
1. Instead of variables you can use of locals to assign the values.
2. You can centralize these using variables but users will be able to override it.

```
locals {
    app_port = 8443
}
```

# Accessing Child Module Outputs
In parent modeule, outputs of child modules are available in expressions as 

```module.<MODULE_NAME>.<OUTPUT_NAME>```

```
resource "aws_security_group" "ec2-sg" {
    name = "myec2-sg"

    ingress {
        description = 
        from_port = 8433
        to_port = 8433
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

output "sg_id" {
    value = aws_security_group.ec2-sg.arn
}
```

```
module "sgmodule" {
    source = "../../modules/sg"
}

resource "aws_instance" "web" {
    ami = "ami-0507f77897697c4ba"
    instance_type = "t2.micro"
    vpc_security_group_ids = [module.sgmodule.sg_id]
}
```

