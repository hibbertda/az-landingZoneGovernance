# Policy: Block Builtin Azure RBAC Roles

An Azure Policy to limit the use of Azure built-in Role Based Access Control (RBAC) roles. The goal is to allow delegation of Identity and Access Management (IAM) while preventing self-service escalation of permissions outside of an assigned scope.

</br>

## RBAC Built-in Roles

As an example the following roles are the default roles that allow a level of access across all of Azure. 

</br>

|Built-in role| ID|
|---|---|
|Owner| 8e3af657-a8ff-443c-a75c-2fe8c4bcb635 |
|Contributor| b24988ac-6180-42a0-ab88-20f7382dd24c |
|Reader| acdd72a7-3385-48ef-bd42-f606fba81ae7 |
|User Access Administrator| 18d7d88d-d35e-4fb5-a5c3-7773c20a72d9 |

</br>

To reference these roles in a policy create a JSON array with the desired role definition IDs. 

```json
{
    "roleDefinitionIds": {
        "value": [
            "8e3af657-a8ff-443c-a75c-2fe8c4bcb635",
            "b24988ac-6180-42a0-ab88-20f7382dd24c",
            "acdd72a7-3385-48ef-bd42-f606fba81ae7",
            "18d7d88d-d35e-4fb5-a5c3-7773c20a72d9"
        ]
    }
}
```