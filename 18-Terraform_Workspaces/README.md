# Terraform WorkSpaces
1. Terraform allows us to have multiple workspaces, with each of the workspace we can have different set of environment variables associated.

## Commands

1. ```terraform workspace list``` - Lists all workspaces.
2. ```terraform workspace show``` - Shows the name of the current workspace.
3. ```terraform workspace new <Name>``` - create a new workspace.
4. ```terraform workspace delete <Name>``` - delete workspace.
5. ```terraform workspace select <Name>``` - select a workspace.