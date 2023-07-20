# Terraform and .gitignore

Depending on the environemnts, it is recommended to avoid committing certain files to GIT.

## Files to ignore
1. .terraform = this file will be recreated when terraform init is run.
2. terraform.tfvars = may contain sensitive data.
3. terraform.tfstate = should be stored in the remote side.
4. crash.log = if terraform crashes, the logs are stored to a file named crash.log.