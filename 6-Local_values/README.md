# Local Values
1. A local value assigns a name to an expression, allowing it to be used multiple times within a module without repeating it.

## Example
```
provider "aws" {}

locals {
    common_tags = {
        owner = "devops team"
        service = "backend"
    }
}

resource "aws_instance" "app-dev" {
    ami = "xyz"
    instance_type = "t2.micro"
    tags = local.common_tags
}
```

2. Local values can be used for multiple different use-cases like having a conditional expression.

```
locals {
    name_prefix = "${var.name != "" ? var.name : var.default}"
}
```

3. Local values can be helpful to avaoid repeating the same values or expressions multiple times in a configuration.

4. If overused they can make a configuration hard to read by future maintainers by hiding the actual values used.

5. Use local values only in moderation, in situations where a single value or result is used in many places and that value is likely to be changed in the future,