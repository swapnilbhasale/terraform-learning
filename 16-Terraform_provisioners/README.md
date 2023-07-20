# Terraform Provisioners

Provisioners are used to execute scripts on a local or remote machine as part of resource creation or destruction.

Create EC2 instance => Install Nginx 

## Example

```
provider "aws" {}

resource "aws_instance" "myec2" {
    ami = "abc"
    instance_type = "t2.micro"
    key_name = "terraform"

    provisioner "remote-exec" {
        inline = [
            "sudo amazon-linux-extras install -y nginx1.12",
            "sudo systemctl start nginx"
        ]

        connection {
            type = "ssh"
            host = self.public_ip
            user = "ec2-user"
            private_key = file("./terraform.pem")
        }
    }
}
```

## Types of provisioners
1. local-exec = allows to invoke local executable after resource is created. One of the most used approach of local-exec is to run ansible-playbooks on the created server after the resource is created.
2. remote-exec = aloows to invoke remote executable after resource is created.

## Overview of Provisioner Types
1. Creation-Time Provisioner = run during creation, not during updating or any other lifecycle. if creation-time provisioner fails, the resource is marked as tainted.
2. Destroy-Time Provisioner = run before the resource is destroyed.

```
resource "aws_instance" "web" {
    # ...

    provisioner "local-exec" {
        when = "destroy"
        command = "echo 'Destroy-time provisioner'"
    }
}
```

### Provisioner - Failure behavior
1. By default, provisioners that fail will also cause the Terrafrom apply itself to fail.
2. The ```on_failure``` setting can be used to change this. The allowed values are:
    1. continue = Ignore the error and continue with creation or destruction.
    2. fail = Raise an error and stop applying (the default behavior). If this is a creation provisioner, taint the resource

```
resource "aws_instance" "web" {
    # ...

    provisioner "local-exec" {
        on_failure = "continue"
        command = "echo 'Destroy-time provisioner'"
    }
}
```

