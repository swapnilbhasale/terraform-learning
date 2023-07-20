# Terraform Settings

1. The special terraform configuration block type is used to configure some behaviors of terraform itself, such as requiring a minimum terraform version to apply to configuration.

## Terraform Version

If the running version of Terraform does not match the constraints specified, Terraform will produce an error and exit without taking any further actions.

```
terraform {
    required_version = "> 0.12.0"
}
```

## Provider Version

```
terraform {
    required_providers {
        mycloud = {
            source = "mycorp/mycloud"
            version = "~> 1.0"
        }
    }
}
```
