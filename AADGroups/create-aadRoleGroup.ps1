<#
.SYNOPSIS
    Automate the creation of AAD group to assign 'customer' roles/permissions.
.DESCRIPTION
    Azure Active Directory groups created to assign custom Azure RBAC roles to grant access to Azure resources. 
    Group will be assigned custom roles at specific levels of the management hierarchy. 
.EXAMPLE
    create-aadRoleGroup.ps1 -customerName IT -environment snb
.PARAMETER customerName
    [string] Customer / Office identifier
.PARAMETER environment
    [string] Three character string identifying target environment. 

    Parameter must match:
        dev - Development
        snb - Sandbox
        prd - Production
.PARAMETER roleType
    [string] NOT IMPLEMENTED
.PARAMETER subscriptionID
    [string] Subscription ID for scope
.NOTES
    General notes
#>

#Requires -Module AzureAD

[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)][string]$customerName,
    [Parameter(Mandatory=$true)][validateSet('dev','snb','prd')][string]$environment,
    [Parameter(Mandatory=$false)][string]$roleType,
    [parameter()][string]$subscriptionID
    
)

# Role types to create. A group will be created for each roleType
$roleTypes = @(
    # Owner
    [PSCustomObject]@{
        role = 'Owner';
        description = 'Customer owner role'
    },
    # Developer
    [PSCustomObject]@{
        role = 'developer';
        description = 'Customer developer role'
    }
)

$AADgroupName = "grp-"+$environment+"-"+$customerName+"_"


$roleTypes | ForEach-Object {

    try {
        New-AzureADGroup -DisplayName $($AADgroupName+$_.role) `
            -Description $_.description `
            -MailEnabled $false `
            -SecurityEnabled $true `
            -MailNickName "NA" `
            -ErrorAction Stop
    }
    catch {
        Write-Error $_
        exit
    }

}

