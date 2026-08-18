az aks get-credentials --resource-group azure-aks-platform-iac-resources --name azure-aks-platform-iac-aks
kubectl apply -f helm/app-chart/templates