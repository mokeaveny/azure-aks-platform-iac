# Set your variables
$appName = "github-actions-aks-oidc"
$githubOrg = "<your-github-username>"
$githubRepo = "<your-repo-name>"
$subId = (az account show --query id -o tsv)

# 1. Create the App Registration
$appId = az ad app create --display-name $appName --query appId -o tsv

# 2. Create the Service Principal
$spId = az ad sp create --id $appId --query id -o tsv

# 3. Assign Contributor role to your subscription
az role assignment create `
  --assignee $appId `
  --role "Contributor" `
  --scope "/subscriptions/$subId"

# 4. Create the OIDC Federated Credential for GitHub Actions (Main Branch)

$subjectString = "repo:${githubOrg}/${githubRepo}:ref:refs/heads/main"

$paramsJson = @"
{
    "name": "github-main-branch",
    "issuer": "https://token.actions.githubusercontent.com",
    "subject": "$subjectString",
    "description": "OIDC access for GitHub Actions",
    "audiences": [
        "api://AzureADTokenExchange"
    ]
}
"@

$tempPath = "$env:TEMP\fed_cred.json"
$paramsJson | Out-File -FilePath $tempPath -Encoding utf8

az ad app federated-credential create --id $appId --parameters "@$tempPath"

Remove-Item -Path $tempPath -ErrorAction SilentlyContinue

# Output the secrets
Write-Host "AZURE_CLIENT_ID: $appId"
Write-Host "AZURE_TENANT_ID: $(az account show --query tenantId -o tsv)"
Write-Host "AZURE_SUBSCRIPTION_ID: $subId"