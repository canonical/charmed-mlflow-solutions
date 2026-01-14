# TODO: Update to use a reusable module instead of defining
# a `juju_application` resource
resource "juju_application" "opentelemetry_collector_k8s_mlflow" {
  count = var.cos_configuration && var.existing_opentelemetry_collector_name == null ? 1 : 0
  charm {
    name     = "opentelemetry-collector-k8s"
    channel  = "1/stable"
    revision = var.opentelemetry_collector_k8s_revision
  }
  model = var.create_model ? juju_model.kubeflow[0].name : var.model
  name  = "opentelemetry-collector-k8s-mlflow"
  storage_directives = {
    persisted = var.opentelemetry_collector_k8s_size
  }
  trust = true
  units = 1
}

resource "juju_integration" "mlflow_mysql_opentelemetry_collector_k8s_grafana_dashboard" {
  count = var.cos_configuration ? 1 : 0
  model = var.create_model ? juju_model.kubeflow[0].name : var.model

  application {
    name     = module.mlflow_mysql.app_name
    endpoint = module.mlflow_mysql.provides.grafana_dashboard
  }

  application {
    name     = var.existing_opentelemetry_collector_name == null ? juju_application.opentelemetry_collector_k8s_mlflow[count.index].name : var.existing_opentelemetry_collector_name
    endpoint = "grafana-dashboards-consumer"
  }
}

resource "juju_integration" "mlflow_mysql_opentelemetry_collector_k8s_metrics_endpoint" {
  count = var.cos_configuration ? 1 : 0
  model = var.create_model ? juju_model.kubeflow[0].name : var.model

  application {
    name     = module.mlflow_mysql.app_name
    endpoint = module.mlflow_mysql.provides.metrics_endpoint
  }

  application {
    name     = var.existing_opentelemetry_collector_name == null ? juju_application.opentelemetry_collector_k8s_mlflow[count.index].name : var.existing_opentelemetry_collector_name
    endpoint = "metrics-endpoint"
  }
}

resource "juju_integration" "mlflow_mysql_opentelemetry_collector_k8s_grafana_logging" {
  count = var.cos_configuration ? 1 : 0
  model = var.create_model ? juju_model.kubeflow[0].name : var.model

  application {
    name     = module.mlflow_mysql.app_name
    endpoint = module.mlflow_mysql.requires.logging
  }

  application {
    name     = var.existing_opentelemetry_collector_name == null ? juju_application.opentelemetry_collector_k8s_mlflow[count.index].name : var.existing_opentelemetry_collector_name
    endpoint = "receive-loki-logs"
  }
}

resource "juju_integration" "mlflow_server_opentelemetry_collector_k8s_grafana_dashboard" {
  count = var.cos_configuration ? 1 : 0
  model = var.create_model ? juju_model.kubeflow[0].name : var.model

  application {
    name     = module.mlflow_server.app_name
    endpoint = module.mlflow_server.provides.grafana_dashboard
  }

  application {
    name     = var.existing_opentelemetry_collector_name == null ? juju_application.opentelemetry_collector_k8s_mlflow[count.index].name : var.existing_opentelemetry_collector_name
    endpoint = "grafana-dashboards-consumer"
  }
}

resource "juju_integration" "mlflow_server_opentelemetry_collector_k8s_metrics_endpoint" {
  count = var.cos_configuration ? 1 : 0
  model = var.create_model ? juju_model.kubeflow[0].name : var.model

  application {
    name     = module.mlflow_server.app_name
    endpoint = module.mlflow_server.provides.metrics_endpoint
  }

  application {
    name     = var.existing_opentelemetry_collector_name == null ? juju_application.opentelemetry_collector_k8s_mlflow[count.index].name : var.existing_opentelemetry_collector_name
    endpoint = "metrics-endpoint"
  }
}

resource "juju_integration" "mlflow_server_opentelemetry_collector_k8s_logging" {
  count = var.cos_configuration ? 1 : 0
  model = var.create_model ? juju_model.kubeflow[0].name : var.model

  application {
    name     = module.mlflow_server.app_name
    endpoint = module.mlflow_server.requires.logging
  }

  application {
    name     = var.existing_opentelemetry_collector_name == null ? juju_application.opentelemetry_collector_k8s_mlflow[count.index].name : var.existing_opentelemetry_collector_name
    endpoint = "receive-loki-logs"
  }
}

resource "juju_integration" "minio_opentelemetry_collector_k8s_grafana_dashboard" {
  count = var.cos_configuration ? 1 : 0
  model = var.create_model ? juju_model.kubeflow[0].name : var.model

  application {
    name     = module.minio.app_name
    endpoint = module.minio.provides.grafana_dashboard
  }

  application {
    name     = var.existing_opentelemetry_collector_name == null ? juju_application.opentelemetry_collector_k8s_mlflow[count.index].name : var.existing_opentelemetry_collector_name
    endpoint = "grafana-dashboards-consumer"
  }
}

resource "juju_integration" "minio_opentelemetry_collector_k8s_metrics_endpoint" {
  count = var.cos_configuration ? 1 : 0
  model = var.create_model ? juju_model.kubeflow[0].name : var.model

  application {
    name     = module.minio.app_name
    endpoint = module.minio.provides.metrics_endpoint
  }

  application {
    name     = var.existing_opentelemetry_collector_name == null ? juju_application.opentelemetry_collector_k8s_mlflow[count.index].name : var.existing_opentelemetry_collector_name
    endpoint = "metrics-endpoint"
  }
}
