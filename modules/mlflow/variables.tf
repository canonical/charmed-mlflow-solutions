variable "risk" {
  type        = string
  description = "Value for the risk to be used"
  default     = "edge"

  validation {
    condition     = contains(["stable", "candidate", "beta", "edge"], var.risk)
    error_message = "Valid values for var: risk are (stable, candidate, beta and edge)."
  }
}

variable "cos_configuration" {
  description = "Boolean value that enables COS configuration"
  type        = bool
  default     = false
}

variable "create_model" {
  description = "Allows to skip Juju model creation and re-use a model created in a higher level module"
  type        = bool
  default     = true
}

variable "enable_mlflow_nodeport" {
  description = "Boolean value that enables the NodePort service for MLflow"
  type        = bool
  default     = true
}

variable "existing_opentelemetry_collector_name" {
  description = "Name of an existing opentelemetry-collector-k8s deployment"
  type        = string
  default     = null
}

variable "opentelemetry_collector_k8s_revision" {
  description = "Charm revision for opentelemetry-collector-k8s"
  type        = number
  default     = null
}

variable "opentelemetry_collector_k8s_size" {
  description = "OpenTelemetry collector storage size"
  type        = string
  default     = "10G"
}

variable "mlflow_default_artifact_root" {
  description = "The default bucket MLflow uses for artifacts"
  type        = string
  default     = "mlflow"
}

variable "mlflow_minio_access_key" {
  description = "MinIO access key for MLflow"
  type        = string
  default     = "minio"
  sensitive   = true
}

variable "mlflow_minio_gateway_storage_service" {
  description = "Gateway storage service configuration for MinIO when in 'gateway' mode for MLflow"
  type        = string
  default     = ""
}

variable "mlflow_minio_mode" {
  description = "MinIO mode for MLflow, either 'server' or 'gateway'"
  type        = string
  default     = "server"
}

variable "mlflow_minio_secret_key" {
  description = "MinIO secret key for MLflow"
  type        = string
  default     = ""
  sensitive   = true
}

variable "mlflow_minio_size" {
  description = "MinIO database storage size"
  type        = string
  default     = "10G"
}

variable "mlflow_minio_storage_service_endpoint" {
  description = "MinIO storage service endpoint for MLflow, required if minio_mode is 'gateway'"
  type        = string
  default     = ""
}

variable "mlflow_minio_revision" {
  description = "Charm revision for mlflow-minio"
  type        = number
  default     = null
}

variable "mlflow_mysql_revision" {
  description = "Charm revision for mlflow-mysql"
  type        = number
  default     = null
}

variable "mlflow_mysql_size" {
  description = "Size allocated for mysql data"
  type        = string
  default     = "10G"
}

variable "mlflow_nodeport" {
  description = "The nodeport for MLflow"
  type        = number
  default     = 31380
}

variable "mlflow_server_revision" {
  description = "Charm revision for mlflow-server"
  type        = number
  default     = null
}

variable "model" {
  description = "Model name"
  type        = string
  default     = "kubeflow"
}

