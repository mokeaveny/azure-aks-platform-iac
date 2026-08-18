# 1. Set your ACR name variable
$ACR_NAME = "azureaksplatformiacacr"

# 2. Authenticate Docker with Azure Container Registry
az acr login --name $ACR_NAME

# 3. Get the login server address (e.g., myacr.azurecr.io)
$ACR_SERVER = $(az acr show --name $ACR_NAME --query loginServer --output tsv)

# 4. Tag your local image for ACR
docker tag aks-demo-api:v1 "$ACR_SERVER/aks-demo-api:v1"

# 5. Push the image up to Azure
docker push "$ACR_SERVER/aks-demo-api:v1"