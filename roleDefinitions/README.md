# Azure Role Based Access Control (RBAC): Custom Role Definitions


Custom role defintions are created at the 'Tenant Root Group' management group scope (assignableScopes). This will allow the roles to be assigned across the entire organization. 

```json

```


## Requirements

In order to deploy to the tenant root group additional permissions need to be assigned. Permissions need to be assigned to the identity that will be creating the deployment. 


```PowerShell
New-AzRoleAssignment -SignInName "[userId]" -Scope "/" -RoleDefinitionName "Owner"
```

Without these additional rights the deployment will fail.

https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deploy-to-tenant?tabs=azure-cli#required-access