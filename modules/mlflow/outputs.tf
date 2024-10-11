output "grafana_agent_k8s" {
  value = var.cos_configuration ? {
    app_name = var.existing_grafana_agent_name == null ? one(juju_application.grafana-agent-k8s-mlflow[*].name) : var.existing_grafana_agent_name
    provides = {
      grafana_dashboards_provider : "grafana-dashboards-provider",
    }
    requires = {
      logging_consumer  = "logging-consumer",
      send_remote_write = "send-remote-write",
    }
  } : null
}

output "minio" {
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
