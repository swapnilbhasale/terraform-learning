# Output Values
1. Output values make information about your infrastructure available on the command line, and can expose information for other Terraform configurations to use.
2. Output values defined in Project A can be referenced from code in Project B as well.

## Example 1

```
# Use case-
# Create a Elastic IP (Public IP) resource in AWS and output the value of the EIP.

provider "aws" {
    region = "us-west-2"
}

resource "aws_eip" "lb" {
    domain = "vpc"
}

output "values" {
    # this value will return all attributes for resource
    value = aws_eip.lb
}
```

```
Outputs:

values = {
  "address" = tostring(null)
  "allocation_id" = "eipalloc-0f689a134a03309ff"
  "associate_with_private_ip" = tostring(null)
  "association_id" = ""
  "carrier_ip" = ""
  "customer_owned_ip" = ""
  "customer_owned_ipv4_pool" = ""
  "domain" = "vpc"
  "id" = "eipalloc-0f689a134a03309ff"
  "instance" = ""
  "network_border_group" = "us-west-2"
  "network_interface" = ""
  "private_dns" = tostring(null)
  "private_ip" = ""
  "public_dns" = "ec2-34-217-167-53.us-west-2.compute.amazonaws.com"
  "public_ip" = "34.217.167.53"
  "public_ipv4_pool" = "amazon"
  "tags" = tomap({})
  "tags_all" = tomap({})
  "timeouts" = null /* object */
  "vpc" = true
}

```

## Example 2
```
provider "aws" {
    region = "us-west-2"
}

resource "aws_eip" "lb" {
    domain = "vpc"
}

output "public-ip" {
    value = "https://${aws_eip.lb.public_ip}:8080
}
```

```
Outputs:

public-ip = "https://34.217.167.53:8080"
```

