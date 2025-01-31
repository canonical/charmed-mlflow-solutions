module "minio" {
  app_name   = "mlflow-minio"
  source     = "git::https://github.com/canonical/minio-operator//terraform?ref=track/ckf-1.9"
  model_name = var.create_model ? juju_model.kubeflow[0].name : var.model
  revision   = var.mlflow_minio_revision
  storage_directives = {
    minio-data = var.mlflow_minio_size
  }
}

module "mlflow_server" {
  source     = "git::https://github.com/canonical/mlflow-operator//terraform?ref=track/2.15"
  model_name = var.create_model ? juju_model.kubeflow[0].name : var.model
  config = {
    enable_mlflow_nodeport = var.enable_mlflow_nodeport,
    mlflow_nodeport        = var.mlflow_nodeport,
  }
  revision = var.mlflow_server_revision
}

module "mlflow_mysql" {
  # tflint-ignore: terraform_module_pinned_source
  source          = "git::https://github.com/canonical/mysql-k8s-operator//terraform?ref=main"
  juju_model_name = var.create_model ? juju_model.kubeflow[0].name : var.model
  app_name        = "mlflow-mysql"
  channel         = "8.0/stable"
  # The following config is equivalent to "constraints: mem=2G"
  config = {
    profile-limit-memory = "2048"
  }
  storage_size = var.mlflow_mysql_size
  revision     = var.mlflow_mysql_revision
}
