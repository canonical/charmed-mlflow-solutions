module "minio" {
  app_name   = "mlflow-minio"
  source     = "git::https://github.com/canonical/minio-operator//terraform?ref=track/1.10"
  model_name = var.create_model ? juju_model.kubeflow[0].name : var.model
  revision   = var.mlflow_minio_revision
  config = {
    access-key               = var.mlflow_minio_access_key,
    secret-key               = var.mlflow_minio_secret_key,
    mode                     = var.mlflow_minio_mode,
    gateway-storage-service  = var.mlflow_minio_gateway_storage_service,
    storage-service-endpoint = var.mlflow_minio_storage_service_endpoint,
  }
  storage_directives = {
    minio-data = var.mlflow_minio_size
  }
  channel = "1.10/${var.risk}"
}

module "mlflow_server" {
  source     = "git::https://github.com/canonical/mlflow-operator//terraform?ref=track/2.22"
  model_name = var.create_model ? juju_model.kubeflow[0].name : var.model
  config = {
    enable_mlflow_nodeport = var.enable_mlflow_nodeport,
    mlflow_nodeport        = var.mlflow_nodeport,
    default_artifact_root  = var.mlflow_default_artifact_root,
  }
  revision = var.mlflow_server_revision
  channel  = "2.22/${var.risk}"
}

module "mlflow_mysql" {
  # tflint-ignore: terraform_module_pinned_source
  source     = "git::https://github.com/canonical/mysql-k8s-operator//terraform?ref=eb6261e6fd1830d80aa4fa260d091c9110c24ba4"
  model_name = var.create_model ? juju_model.kubeflow[0].name : var.model
  app_name   = "mlflow-mysql"
  channel    = "8.0/stable"
  # The following config is equivalent to "constraints: mem=2G"
  config = {
    profile-limit-memory = "2048"
  }
  storage_size = var.mlflow_mysql_size
  revision     = var.mlflow_mysql_revision
}
