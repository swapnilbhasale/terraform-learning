# Tainting Resources

## Understanding the Use-case
1. You have created a new resource via Terraform
2. Users have made a lot of manual changes (both infra and inside the server)
3. 2 ways to deal with this: 
    1. Import changes to Terraform
    2. Delete and recreate the resource

## Recreating the Resource

The ```-replace``` option with ```terraform apply``` to force Terraform to replace an object even though there are no configuration changes that would require it.

```terraform apply -replace="aws_instance.web"```

## Note

1. Similar functionality wa achieved using the ```terraform init``` command in older terraform versions.
2. For Terraform v0.15.2 and later, it is recommended to use -replace option with terraform apply.