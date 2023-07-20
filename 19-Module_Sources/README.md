# Module Sources

1. The source argument in a module block tells Terraform where to find the source code for the desired child module.

```
module "consul" {
    source = "app.terraform.io/..."
    version = "1.1.0"
}
```

## Git Module source
1. Git reposotories can be used by prefixing the address with the special git:: prefix.
2. After the prefix any valid Git URL can be specified to select one of the protocols supported by Git. 

### Referencing to a Branch
1. By default, Terraform will clone and use the default branch in the selected repository.
2. You can override this using the ref argument. the value of ref argument can be any reference that would be accepted by the git checkout command, including branch and tag names.

```
module "vpc" {
    source = "git::https://example.com/vpc.git?ref=v1.2.0"
}
```