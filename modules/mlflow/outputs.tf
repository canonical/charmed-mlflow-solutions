output "opentelemetry_collector_k8s" {
  value = var.cos_configuration ? {
    app_name = var.existing_opentelemetry_collector_name == null ? one(juju_application.opentelemetry_collector_k8s_mlflow[*].name) : var.existing_opentelemetry_collector_name
    provides = {
      grafana_dashboards_provider : "grafana-dashboards-provider",
    }
    requires = {
      send_loki_logs    = "send-loki-logs",
      send_remote_write = "send-remote-write",
    }
  } : null
}

output "mlflow_minio" {
  value = {
    app_name = module.minio.app_name,
    provides = module.minio.provides,
  }
}

output "mlflow_server" {
  value = {
    app_name = module.mlflow_server.app_name,
    provides = module.mlflow_server.provides,
    requires = module.mlflow_server.requires,
  }
}

output "model_name" {
  value = var.create_model ? juju_model.kubeflow[0].name : var.model
}
