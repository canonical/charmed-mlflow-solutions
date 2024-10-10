module "minio" {
  app_name   = "mlflow-minio"
  source     = "git::https://github.com/canonical/minio-operator//terraform?ref=track/ckf-1.9"
  model_name = var.create_model ? juju_model.kubeflow[0].name : var.model
  storage_directives = {
    minio-data = var.minio_size
  }
}

module "mlflow_server" {
  source     = "git::https://github.com/canonical/mlflow-operator//terraform?ref=track/2.15"
  model_name = var.create_model ? juju_model.kubeflow[0].name : var.model
}

module "mlflow_mysql" {
  # tflint-ignore: terraform_module_pinned_source
  source              = "git::https://github.com/canonical/terraform-modules//modules/k8s/mysql?ref=main"
  juju_model_name     = var.create_model ? juju_model.kubeflow[0].name : var.model
  mysql_app_name      = "mlflow-mysql"
  mysql_charm_channel = "8.0/stable"
  mysql_charm_units   = 1
  # Constrain is a required workaround due to https://github.com/juju/terraform-provider-juju/issues/344
  mysql_charm_constraints = "arch=amd64"
  # The following config is equivalent to "constraints: mem=2G"
  mysql_charm_config = {
    profile-limit-memory = "2048"
  }
  mysql_storage_size   = var.mlflow_mysql_size
  mysql_charm_revision = var.mlflow_mysql_revision
}
