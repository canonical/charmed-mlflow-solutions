resource "juju_integration" "mlflow_server_minio_object_storage" {
  model = var.create_model ? juju_model.kubeflow[0].name : var.model

  application {
    name     = module.mlflow_server.app_name
    endpoint = module.mlflow_server.requires.object_storage
  }

  application {
    name     = module.minio.app_name
    endpoint = module.minio.provides.object_storage
  }
}

resource "juju_integration" "mlflow_server_mlflow_mysql_relational_db" {
  model = var.create_model ? juju_model.kubeflow[0].name : var.model

  application {
    name     = module.mlflow_server.app_name
    endpoint = module.mlflow_server.requires.relational_db
  }

  application {
    name     = module.mlflow_mysql.application_name
    endpoint = "database"
  }
}
