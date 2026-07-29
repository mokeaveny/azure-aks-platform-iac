$resourceGroupName = "azure-aks-platform-iac-management-resources"
$location = "uksouth"
$storageAccountSuffix = Get-Random -Minimum 10000 -Maximum 99999
$storageAccountName = "tfstate$storageAccountSuffix"
$containerName = "tfstate"

# 1. Create the management resource group
az group create `
  --name $resourceGroupName `
  --location $location

# 2. Create the storage account
az storage account create `
  --resource-group $resourceGroupName `
  --name $storageAccountName `
  --sku Standard_LRS `
  --encryption-services blob

# 3. Create the blob container for tfstate
az storage container create `
  --name $containerName `
  --account-name $storageAccountName