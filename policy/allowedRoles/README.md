# Azure Policy - Allowed Roles

This policy will restrict assignment of Azure role to a specified whitelist. Attempting to assign an unauthorized role will be blocked. 

## Template

Two templates are included with this example. 

- **poldef-allowedRoles.azrm.json** - Creates custom policy definition
- **polassign-allowedRoles.azrm.json** - Creates policy assignment, includes list of allowed role definitions. 

### Policy Definitions - Allowed Roles

This template will create the custom policy definitions for Allowed Roles. I recommend deploying this policy definition to the tenant root group, or the highest management group level possible in order to make it widley available across the organization. 

Three parameters are required. First is the **scopedMG** with the ID of the management group where the policy definition will be deployed. 

```json
        "scopedMG": {
            "value": "jsonMG2"
        },
```

Secondly are two parameters required to ensure the syntax of the policy definition is interpreted during the ARM deployment. **Do not modify these values in the parameters file, it will cause the deployment to fail**

```json
        "roleDefinitionIds": {
            "value": "[parameters('roleDefinitionIds')]"
        },
        "policyEffect": {
            "value": "deny"
        }
```

### Policy Assignment - Allowed Roles

Template has two required parameters.

#### targetManagementGroup

The target management group to deploy the policy assignment.

```json
        "targetManagementGroup": {
            "value": ""
        },
```

#### allowedRoleDefinitions

The list of allowed roles are defined in the **allowedRoleDefinitions** parameter. The role value does require the full identifier, including:

```
/providers/Microsoft.Authorization/roleDefinitions/
```

```json
"allowedRoleDefinitions": {
            "value": [
                "/providers/Microsoft.Authorization/roleDefinitions/acdd72a7-3385-48ef-bd42-f606fba81ae7",
                "/providers/Microsoft.Authorization/roleDefinitions/4d97b98b-1d4f-4787-a291-c67834d212e7",
                "/providers/Microsoft.Authorization/roleDefinitions/434105ed-43f6-45c7-a02f-909b2ba83430",
                "/providers/Microsoft.Authorization/roleDefinitions/39bc4728-0917-49c7-9d2c-d95423bc2eb4",
                "/providers/Microsoft.Authorization/roleDefinitions/5e467623-bb1f-42f4-a55d-6e525e11384b",
                "/providers/Microsoft.Authorization/roleDefinitions/fa23ad8b-c56e-40d8-ac0c-ce449e1d2c64",
                "/providers/Microsoft.Authorization/roleDefinitions/73c42c96-874c-492b-b04d-ab87d138a893",
                "/providers/Microsoft.Authorization/roleDefinitions/6d8ee4ec-f05a-4a1d-8b00-a9b17e38b437",
                "/providers/Microsoft.Authorization/roleDefinitions/ba92f5b4-2d11-453d-a403-e96b0029c9fe",
                "/providers/Microsoft.Authorization/roleDefinitions/2a2b9908-6ea1-4ae2-8e65-a410df84e7d1",
                "/providers/Microsoft.Authorization/roleDefinitions/741d35ae-44d8-5325-9f67-8fdf5475e74f",
                "/providers/Microsoft.Authorization/roleDefinitions/4bd27d38-32d3-5c06-bb67-53aafb05a492"
            ]
        }
```

<br>

## Role Definitions

<br>

### Built-in Role Definitions

Built-in role definitions are included by default in Azure. Built around common usecases for services and capabilities. The roles and role IDs are constant across all Azure environments/versions.

In this template example the following built-in role definitons are included in the allowed list.

<br>

| Role Name | Description | ID |
|---|---|---|
|Reader |View all resources, but does not allow you to make any changes.|acdd72a7-3385-48ef-bd42-f606fba81ae7|
|Cost Management Contributor|Can view costs and manage cost configuration (e.g. budgets, exports)|434105ed-43f6-45c7-a02f-909b2ba83430|
|Network Contributor|Lets you manage networks, but not access to them.|4d97b98b-1d4f-4787-a291-c67834d212e7|
|Security Reader|View permissions for Security Center. Can view recommendations, alerts, a security policy, and security states, but cannot make changes.|39bc4728-0917-49c7-9d2c-d95423bc2eb4|
|Backup Contributor|Lets you manage backup service, but can't create vaults and give access to others|5e467623-bb1f-42f4-a55d-6e525e11384b|
|Billing Reader|Allows read access to billing data|fa23ad8b-c56e-40d8-ac0c-ce449e1d2c64|
|Log Analytics Reader|Log Analytics Reader can view and search all monitoring data as well as and view monitoring settings, including viewing the configuration of Azure diagnostics on all Azure resources.|73c42c96-874c-492b-b04d-ab87d138a893|
|SQL Server Contributor|	Lets you manage SQL servers and databases, but not access to them, and not their security-related policies.|6d8ee4ec-f05a-4a1d-8b00-a9b17e38b437|
|Storage Blob Data Contributor|Read, write, and delete Azure Storage containers and blobs.|b7e6dc6d-f1e8-4753-8033-0f276bb0955b|
|Storage Blob Data Reader|Read and list Azure Storage containers and blobs.|2a2b9908-6ea1-4ae2-8e65-a410df84e7d1|

https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles

<br>

### Custom Role Definitions

Custom role definitions will have an ID unique to the environment and the role. To include a custom definitions to the list, capture the ID. The following PowerShell example will list all of the custom role definitions in the directory.

```powershell
Get-AzRoleDefinition -Custom | Select-Object Name, ID
```

The paramert example includes two custom role definitions from my Azure lab. These will need to be removed before attempting to use in another environment or the deployment will fail. 

```powershell
Name      Id
----      --
cr-owner  4bd27d38-32d3-5c06-bb67-53aafb05a492
cr-reader 741d35ae-44d8-5325-9f67-8fdf5475e74f
```