1. Following is the snippet of Terraform code that is part of the AWS VPC Module.

    ```
    variable "vpc_cidr_block" {
      type = map
      default = {
        us-east-1 = "192.168.10.0/24"
        ap-south-1 = "192.168.20.0/24"
        us-west-2  = "10.77.0.0/16"
      }
    }
    ```

    If there is a requirement to fetch the value of 10.77.0.0/16 associated with a specific variable?

    Answer: ```var.vpc_cidr_block["us-west-2"]```

2. Matthew is implementing Terraform in production. 

    He realized that every region in AWS has a different AMI ID for CentOS 7 OS.

    He wants to create a Terraform code that works for all the regions. 

    He has already created the EC2 resource but needs to figure on how he can deal with different AMI IDs based on regions? What is the best approach? 

    Answer: Using Data source, we can query for latest AMI ID based on specific conditions like availability, Operating System or other.

3. There is something wrong with the Terraform version that Alice is using. The HashiCorp team has requested to store the crash logs to a file and send the file over email.

    What is the way for Alice to store the logs to a file named /tmp/kplabs-tf-crash.log 

    Answer: Create a env variable named ```TF_LOG_PATH=/tmp/kplabs-tf-crash.log```

4. Matt has a requirement to reference a local value to another local value in the same terraform code.

    Is this feature supported in Terraform?

    Answer: The locals block defines one or more local variables within a module. Each locals block can have as many locals as needed. https://www.terraform.io/language/configuration-0-11/locals

5. Bob intends to pull the Terraform Module associated with AWS VPC.

    In the line 3, there is a version argument that is defined. Is it a mandatory requirement to specify version while pulling code from Terraform Registry?

    ```
    module "vpc" {
        source  = "terraform-aws-modules/vpc/aws"
        version = "3.14.2"
    }
    ```

    Answer: If we do not specify the version argument, Terraform will download the newest version of the module.

6. Based on the following Terraform code, what is the name of IAM User that will be created?

    ```
    variable "elb_names" {
      type = list
      default = ["dev-loadbalancer", "stage-loadbalanacer","prod-loadbalancer"]
    }
     
    resource "aws_iam_user" "lb" {
      name = var.elb_names[count.index]
      count = 2
      path = "/system/"
    }
    ```

    Answer: dev-loadbalancer and stage-loadbalanacer

7. Andrew wants to read the contents of the file named id_rsa using Terraform.

    Which terraform function can be used to achieve this use-case?

    Answer: file. https://www.terraform.io/language/functions/file

8. Refer to the following CLI Code:

    ```
    locals {
      db_password = {
        admin = "password"
      }
    }
     
    output "db_password" {
      value = local.db_password
    }
    ```

    Whenever a terraform apply operation runs, the value of password is shown in the CLI.

    What is the easiest way to hide the value from CLI?

    Answer: Use the ```sensitive``` parameter.

9. Alice is writing a module and within the module, there are multiple places where she has defined the same set of Terraform expression.

    Whenever there is modification required in the expression, Alice has to go through multiple places in the code and modify everywhere.

    What is a better approach to dealing with this?

    Answer: Local Values.

10. Matthew has created an EC2 instance via Terraform. Matthew has defined the following rules within the security group:

    Port 443 allowed from 0.0.0.0/0
    Port 22 allowed from 125.36.50.23/32

    John has added the following rule manually:

    Port 80 allowed from 0.0.0.0/0

    Next time when Matthew runs a terraform plan, what will happen?

    Answer: terraform plan will show output to remove the manually created rule.

11. James has decided to not use the terraform.tfvars file, instead, he wants to store all data into custom.tfvars file?  

    How can he deal with this use-case while running terraform plan?

    Answer: ```terraform plan -var-file="custom.tfvars"```

12. Matthew has written the configuration file of a manually created EC2 instance in Terraform. Following is the code:

    ```
    resource "aws_instance" "myec2" {
      ami = "ami-bf5540df"
      instance_type = "t2.micro"
      vpc_security_group_ids = ["sg-6ae7d613", "sg-53370035"]
      key_name = "remotepractical"
      subnet_id = "subnet-9e3cfbc5"
     
      tags {
        Name = "manual"
      }
    }
    ```

    The instance id of the manually created EC2 instance is i-041886ebb7e9bd20 How he can import data of that EC2 to the state file and link it with the resource block?

    Answer: ```terraform import aws_instance.myec2 i-041886ebb7e9bd20```

13. John is working as a DevOps Engineer and is managing the Terraform Infrastructure.

    Based on a new requirement, John has to create a new security group (firewall) and 60 different ports needs to be whitelisted in this firewall.

    John wants to avoid writing 60 different ingress blocks and maintain (add/remove) whenever a new IP address need to be added or removed in the subsequent updates.

    ```
    ingress {
        description      = "kplabs-sg"
        from_port        = 443
        to_port          = 443
        protocol         = "tcp"
        cidr_blocks      = 172.31.0.5
    }
    ```

    Which Terraform functionality can John use to minimize the overall Terraform code that can also be managed easily?

    Answer: dynamic block - https://www.terraform.io/language/expressions/dynamic-blocks 

14. Alice has added a simple variable definition in Terraform code.

    ```
    variable "kpnumber" { 
        default = 3
    }
    ```

    Alice has also have a defined the following environment variable: TF_kpnumber=6, TF_VAR_kpnumber=9.

    There is also a terraform.tfvars file with the following contents

    kpnumber = 7

    When you run the following apply command, what is the value assigned to the number variable?

    terraform apply -var kpnumber=4 

    Answer: 4

    Precedence Order:
        1. Environment variables.
        2. terraform.tfvars file, if present.
        3. terraform.tfvars.json file, if present.
        4. Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
        5. Any -var and -var-file options on the command line, in the order they are provided. (This includes variables set by a Terraform Cloud workspace).
    
15. There is an older version of provider that is configured in the .terraform directory. There is a requirement to upgrade to the latest version of the provider.

    Which terraform command can be used to easily achieve this?

    Answer: ```terraform init -upgrade```

16. Alice works for Enterprise Corp and they have recently started to use Terraform Cloud.

    What is the way in which the log output of terraform plan and apply operation that are running in Terraform Cloud be streamed in the local terminal?

    Answer: Remote backends.

17. James has created a variable and has explicitly defined the type as a string. Following is the snippet:

    ```
    variable "myvar" {
        type = string
    }
    ```

    Which of the following value will be accepted?

    Answer: Both 2 and "2" will be accepted. Terraform automatically converts number and bool values to strings when needed.

18. Enterprise Corp is using the count parameter to create 50 set of IAM users from a specific list.

    Following is a sample configuration code:

    ```
    resource "aws_iam_user" "lb" {
        name = var.elb_names[count.index]
        count = 50
        path = "/system/"
    }
    ```

    There is an attribute associated with resource of aws_iam_user named arn.

    There is a requirement that the ARN associated with all 50 IAM Users should be shown in the CLI .

    What of the following syntax can be used as initials to achieve this? 

    Answer: ```aws_iam_user.lb[*].arn```

19. There are a total of 3 workspaces available in a Terraform project.

    workspacea, workspaceb, workspacec.

    Matthew wants to create an additional workspace named testing.  Which command will create a new workspace?

    Answer: ```terraform workspace new testing```

20. Which of the following block allows setting the credentials required while defining Terraform provisioners?

    Answer: connection block. https://www.terraform.io/language/resources/provisioners/connection#example-usage 

21. What are the OS that are supported by Terraform Enterprise?

    Answer:

        1. Ubuntu
        2. Oracle Linux
        3. RedHat Enterprise Linux
        4. CentOS
        5. Amazon Linux
        6. Debian

22. Matthew wants to import a local module named database.

    Which of the following configuration parameter can be used?

    Answer: ```module "db" {source="./database"}``` or ```module "db" {source="../database"}```

23. Which Terraform backends support State locking functionality?

    Answer:

        1. S3
        2. azurerm
        3. consul
    https://www.terraform.io/language/state/locking

24. Which data storage is supported in Terraform enterprise?

    Answer: PostgreSQL - https://www.terraform.io/enterprise/install/pre-install-checklist 

25. Which VCS Providers are supported in Terraform Cloud?

    Answer:

        1. GitHub
        2. BitBucket Cloud
        3. Azure DevOps Services
        4. Azure DevOps Server
    https://www.terraform.io/docs/cloud/vcs/index.html

26. Which OS is Terraform supported in?

    Answer: 

        1. Linux
        2. macOS
        3. Solaris
        4. Windows

27. The name of a variable can be any valid identifier except the following:

    1. source
    2. version
    3. providers
    4. count
    5. for_each
    6. lifecycle
    7. depends_on
    8. locals

28. Small Corp has started to store the Database Secrets in HashiCorp Vault.

    There is a requirement to reference the secrets of Vault into Terraform.

    What approach can be used to achieve this use-case?

    Answer: Vault Provider

29. Which Terraform feature prevents state corruption when multiple users are trying to perform write operation on the same state file at the same time?

    Answer: State Locking

30. Does terraform fmt command scan the code from all the sub-directories as well?

    Answer: By default, fmt scans the current directory for configuration files. If the dir argument is provided then it will scan that given directory instead.

31. James has used terraform state rm command against a specific resource.

    On the next terraform apply, will it destroy the resource?

    Answer: Upon running terraform state rm command, Terraform will search the state for any instances matching the given resource address, and remove the record of each one so that Terraform will no longer be tracking the corresponding remote objects.

32. James has decided to migrate the Terraform state file from localhost to S3 bucket

    In order to move the state, James has written the following code:

    ```
    terraform {
        backend "s3" {
            bucket = "mybucket"
            key    = "path/to/my/key"
            region = "us-east-1"
        }
    }
    ```

    Which command does James need to run to migrate your current state store locally to the S3 backend?

    Answer: ```terraform init```

33. What is the way to reference the private_ip attribute from the following Terraform code?

    ```
    resource "aws_eip" "kpl" {
      instance = aws_instance.web.id
      vpc      = true
    }
    ```

    Answer: ```aws_eip.kpl.private_ip```

34. Alice has created a new Public IP in AWS using following code

    ```
    resource "aws_eip" "lb" {
      vpc      = true
    }
    ```

    The Public IP was successfully created in AWS but the IP details was not shown in the CLI. Alice forgot to add "output" section in code that would display the IP details.

    What is the way in which Alice can find the IP Address details without having to login to AWS?

    Answer: ```terraform state show aws_eip.lb```

35. Command to ensure code is syntactically valid and internally consistent 
    
    Answer: ```terraform validate```

36. You have the following code snippet as part of your Terraform configuration. How would you reference the id of the s3_bucket?

    ```
    data "aws_s3_bucket" "data_bucket" {
      bucket = "my-data-lookup-bucket-bk"
    }
    ```

    Answer: ```data.aws_s3_bucket.data_bucket.id```

    General syntax : ```data.<resource_type>.<resource_name>.id```

37. By default, where does Terraform store its state file?

    Answer: ```terraform.tfstate```

38. What 2 options are available to delete all managed infrastructure?

    Answer: ```terraform destroy``` or ```terraform apply -destroy```

39. What command can you use to display details about the resource as shown below?

    ```
    resource "aws_internet_gateway" "demo" {
      vpc_id = aws_vpc.vpc.id
      tags = {
        Name = "demo_igw"
      }
    }
    ```

    Answer: ```terraform state show aws_internet_gateway.demo```

40. What flag would you use to perform a dry-run of your changes and save the proposed changes to a file for future use?

    Answer: ```terraform plan -out=<filename>```

41. You want Terraform to redeploy a specific resource that it is managing. What command should you use to mark the resource for replacement?

    Answer: ```terraform apply -replace```

42. What command can be used to get an interactive console to evaluate expressions in your Terraform code?

    Answer: ```terraform console```

43. When using constraint expressions to signify a version of a provider, which of the following are valid provider versions that satisfy the expression found in the following code snippet

    ```
    terraform {
        required_providers {
            aws = "~> 1.2.0"
        }
    }

    Answer: 1.2.1 to 1.2.9 provider versions satisfy the given "~> 1.2.0" constraint

44. Terraform is an immutable, decalrative, Infrastructure as Code provisioning language based on Hashicorp Configuration Language (HCL), or optionally JSON.

45. ```terraform init``` is used to initialize a Terraform working directory, and you will need to rerun it whenever you make changes to your code that affect the providers, modules, or versions you are using.

46. Terraform Available Backends

    1. local
    2. remote
    3. consul
    4. s3
    5. kubernetes
    6. azurerm
    7. cos
    8. gcs
    9. http
    10. pg
    11. oss

47. When you add a new module to a configuration, Terraform must download it before it can be used. What two commands can be used to download and update modules?

    Answer: ```terraform init``` and ```terraform get```

48. Module sources supported by Terraform.

    Answer:
        1. Local Paths
        2. Terraform Registry
        3. GitHub
        4. Bibucket
        5. Generic Git, Mercurial repos
        6. HTTP URLs
        7. S3 buckets
        8. GCS buckets
        9. Modules in Package Sub-directories




