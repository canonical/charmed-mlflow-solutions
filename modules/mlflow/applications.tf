module "minio" {
  app_name   = "mlflow-minio"
  source     = "git::https://github.com/canonical/minio-operator//terraform?ref=9c1d621124df098c24e00329c0d2e1b12b9bc4fa"
  model_name = var.create_model ? juju_model.kubeflow[0].name : var.model
  revision   = var.mlflow_minio_revision
  storage_directives = {
    minio-data = var.mlflow_minio_size
  }
}

module "mlflow_server" {
  source     = "git::https://github.com/canonical/mlflow-operator//terraform?ref=6c2cd2e5cca8b04b26b1e3b886f220d9a3de3963"
  model_name = var.create_model ? juju_model.kubeflow[0].name : var.model
  config = {
    enable_mlflow_nodeport = var.enable_mlflow_nodeport,
    mlflow_nodeport        = var.mlflow_nodeport,
  }
  revision = var.mlflow_server_revision
}

module "mlflow_mysql" {
  # tflint-ignore: terraform_module_pinned_source
  source          = "git::https://github.com/canonical/mysql-k8s-operator//terraform?ref=4f198a8a2787a25da89c1240b3bf7efd1a7d1228"
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
