
[CmdletBinding()]
param (
    [Parameter(Mandatory=$false)][string]$parameterPath = ".\role_definitions\",
    [Parameter(Mandatory=$true)][string]$tenantRootMG,
    [Parameter(Mandatory=$false)][string]$azLocation = "centralus"
)

# Import custom role definition ARM parameter file(s)
$roleDefinitions = (Get-ChildItem -Path $parameterPath | Where-Object {$_.name -like "*parameters.json"}).fullname

$roleDefinitions | ForEach-Object {
    New-AzManagementGroupDeployment -ManagementGroupId $tenantRootMG `
        -Location $azLocation `
        -TemplateFile .\azCustomRole.azrm.json `
        -TemplateParameterFile $_ `
        -tenantRootID $tenantRootMG 
}