# Azure Policy: TagInheritance

Policy to automatically push tags from Subsription/Resource Groups to all child resources. This policy is targeted to be applied at the Tenant Root Group to have a consistent application across the organization. 


<hr>

### Notes:

<br>

Azure Policy /Initative deployment through ARM template can experience complications when setting policy parameters, which can cause a conflict with ARM parameters. To work around this the parameters file sets the parameters in a loop back to ensure the correct value is passed to the policy engine. 

```json

        "environment": {
            "value": "[parameters('environment')]"
        },
        "costCenter": {
            "value": "[parameters('costCenter')]"  
        },
        "customer": {
            "value": "[parameters('customer')]"   
        },
        "technicalPOC": {
            "value": "[parameters('technicalPOC')]"   
        },
        "appName": {
            "value": "[parameters('appName')]" 
        },
        "appOwner": {
            "value": "[parameters('appOwner')]"     
        },
        "dataClassification": {
            "value": "[parameters('dataClassification')]"  
        }
    }

```

These values cannot be added to the policy directly as a 'defaultValue', it will cause a loopback syntax error when deploying the template. 