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

variable "existing_grafana_agent_name" {
  description = "Name of an existing grafana-agent-k8s deployment"
  type        = string
  default     = null
}

variable "grafana_agent_k8s_revision" {
  description = "Charm revision for grafana-agent-k8s"
  type        = number
  default     = null
}

variable "grafana_agent_k8s_size" {
  description = "Grafana agent database storage size"
  type        = string
  default     = "10G"
}

variable "mlflow_minio_size" {
  description = "MinIO database storage size"
  type        = string
  default     = "10G"
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
