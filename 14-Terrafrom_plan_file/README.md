# Terraform Plan File

1. The generated terraform plan can be saved to a specific path
2. This plan can then be used with terraform apply to be certain that only the changes shown in this plan are applied.

## Example

```
terraform plan -out=<filename>
```

This saved plan can be applied
```
terraform apply <filename>
```