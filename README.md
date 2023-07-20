# Terraform

## Terraform Providers
1. A provider is responsible for understanding API interactions and exposing resources.
2. Most of the available providers correspond to one cloud or on-premises infrastructure platform, and offer resource types that correspond to each of the features of the platform.
3. You can explicitly set a specific version of the provider within the provider block.
To upgrade to the latest acceptable version of each provider, run ```terraform init -upgrade```.
4. You can have multiple providers instances with the help of ```alias```
    ```
    provider "aws" {
        region = "us-east-1"
    }
    provider "aws" {
        alias = "west"
        region = "us-west-2"
    }
    ```
    The provider block without alias set is known as the default provider configuration. When an alias is set, it creates an additional provider configuration.

## Terraform Init
1. This command is used to initialize a working directory containing terraform config files.
2. Terraform must initialize the provider before it can be used.
3. Initialization downloads and installs the providers plugin so that it can be executed later.

## Terraform Plan
1. This command creates an execution plan.
2. It will not modify things in the infrastructure.
3. Terraform performs a refresh, unless explicitly disabled, and then determines what actions are necessary to achieve the desired state specified in the config files.

## Terraform Apply
1. This command applies the changes required to reach the desired state of the configuration.
2. Terraform apply will also write date to the terraform.tfstate file.
3. Once apply is completed, resources are immediately available.

## Terraform Refresh
1. This command is used to reconsile the state Terraform knows about (via its state file) with the real-world infrastructure.
2. This does not modify infrastructure but does modify the state file.
3. The terraform refresh command reads the current settings from all managed remote objects and updates the Terraform state to match.

## Terraform Destroy
1. Command is used to destroy terraform managed infrastructure.
2. terraform destroy is not the only command through which infrastructure can be destroyed.

## Terraform Format
1. terraform fmt command is used to rewrire Terraform configuration files to a canonical format and style.

## Terraform Validate
1. Command validates the configuration files in a directory.
2. Validate runs checks that verify whether a config is syntactically valid and thus primarily useful for general verification of reusable modules, including the correctness of attribute names and value types.
3. It is a safe to run this command automatically.
4. Validation requires an initialized working directory with any referenced plugins and modules installed.

## Terraform Provisioners
1. Provisioners can be used to model specific actions on the local machine or on a remote machine in order to prepare servers or other infrastructure objects for service.
2. Provisioners should only be used as a last resort. For most common situations, there are better alternatives.
3. Provisioners are inside the resource block.

    ```
    resource "aws_instance" "web" {
        # ...

        provisioner "local-exec" {
            command = # ...
        }
    }
    ```
4. By default, provisioners that fail will cause the terraform apply to fail. The on_failure setting can be used to change this. The allowed values are ```continue``` and ```fail```.
    1. continue = ignore the error and continue with creation or destruction.
    2. fail = raise an error and stop applying (default behaviour). If this is a creation provisioner, taint the resource.

## Terraform Debugging
1. Enabled by setting the TF_LOG environment variable to any log level - TRACE, DEBUG, INFO, WARN, or ERROR to change the verbosity of the logs. TF_LOG=TRACE
2. To persist logged output, set TF_LOG_PATH env variable.

## Terraform Import
1. Terraform allows to import exisiting infrastructure.

## Local Values
1. A local value assigns a name to an expression, allowing it to be used multiple times within a module without repeating it.

## Terraform WorkSpaces
1. Terraform allows us to have multiple workapces; with each of the workspaces, we can have a different set of env variables associated.
2. Workspaces allow multiple state files of a single configuration.
3. Workspaces are managed with terraform workspace set of commands.
4. State file directory = terraform.tfstate.d
5. Not suitable for isolation for strong separation between workspace (stage/prod).
6. ```terraform workspace new prod``` = create new workspace.
7. ```terraform workspace select prod``` = switch to specific workspace.

## Terraform Lock
1. If supported by the backend, terraform will lock the state for all operations that could write state.
2. Terraform has a force-unlock command to manually unlock the state if unlocking failed.

## Terraform Graph
1. terraform graph command is used to generate a visual representation of either a configuration or execution plan.
2. The output of terraform graph is in the DOT format, which can be converted to an image file.

## Splat Expressions
1. Splat expression allows us to get a list of all the attributes.
    ```
    resource "aws_iam_user" "lb" {
        name = "iamuser.${count.index}
        count = 3
        path = "/system/"
    }

    output "arns {
        value = aws_iam_user.lb[*].arn
    }
    ```

## Terraform Taint
1. Command marks a terraform-managed resource as tainted, forcing it to be destroyed and recreated on the next apply.
2. Once a resource is marked as tainted, the next plan will show that the resource will be destroyed and recreated and the next apply will implement this change.

## Input Varialbles
1. The value associated with a variable can be assigned via multiple approaches.
    ```
    variable "image_id" {
        type = string
    }
    ```
    Value associated with the variables can be defined via CLI as well as in ```terraform.tfvars``` file.
2. Following is syntax to laod custom tfvars file:
    ``` terraform apply -var-file="testing.tfvars"```

## Fetching values from Map
1. To reference to "image-abc" from the below map, the following approaches may be used.

    ```var.ami_ids["mumbai"]```

    ```
    variable "ami_ids" {
        type = "map"
        default = {
            "mumbai"  = "image-abc"
            "germany" = "image-def"
            "states"  = "image-xyz"
        }
    }
    ```

## Dependency Types - Implicit
1. Terraform can automatically find references of the object, and create an implicit ordering requirement between the 2 resources.
    ```
    resource "aws_eip" "my_eip" {
        vpc = "true"
    }

    resource "aws_instance" "my_ec2" {
        instance_type = "t2.micro"
        public_ip = aws_eip.myeip.private_ip
    }
    ```

    In the above config, terraform will first create the aws_eip as it is required for the ec2 instance creation.

## Dependency Types - Explicit
1. Explicitly specifying a dependency is only necessary when a resource relies on some other resource's behavior but does not access any of that resource's data in its arguments.
    ```
    resource "aws_s3_bucket" "example" {
        acl = "private"
    }

    resource "aws_instance" "myec2" {
        instance_type = "t2.micro"
        depends_on = [aws_s3_bucket.example]
    }
    ```

## Terraform Plan Destroy
1. Behavior of any terraform destroy command can be previewed at any time with an equivalent ```terraform plan -destroy``` command.

## Dealing with Larger Infrastructure
1. Cloud providers has certain amount of rate limiting set so Terraform can only request certain amount of resources over a period of time.
2. It is important to break larger configurations into multiple smaller configurations that can be independently applied.
3. (Not recommended) Use -refresh=false and target flag for a workaround.

## Local Values
1. A local value assigns a name to an expression, allowing it to be used multiple times within a module without repeating it.

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

## Terraform Version Constraints

### Valid Operators
1. ```= ```(or no operator) : allows only one exact version number. Cannot be combined with other conditions.
2. ```!=``` : Excludes an exact version number.
3. ```>, >=, <, <=``` : Comparisons against a specified version.
4. ```~>``` : Allows only the rightmost version component to increment. For example, ~> 1.0.4 will allow installation of 1.0.5 and 1.0.10 but not 1.1.0