variable "project_name" {
  type        = string
  default     = "azure-aks-platform-iac"
  description = "The name of the project"
}

variable "location" {
  type        = string
  default     = "UK South"
  description = "The Azure region where resources will be deployed"
}

variable "environment" {
  type        = string
  default     = "DEV"
  description = "Environment tag (e.g. DEV, PREPROD, PROD)"
}