output "grafana_agent_k8s" {
  value = var.cos_configuration ? {
    app_name : var.existing_grafana_agent_name == null ? one(juju_application.grafana-agent-k8s-mlflow[*].name) : var.existing_grafana_agent_name
    provides : {
      grafana_dashboards_provider : "grafana-dashboards-provider",
    }
    requires : {
      logging_consumer : "logging-consumer",
      send_remote_write : "send-remote-write",
    }
  } : null
}

output "model_name" {
  value = var.create_model ? juju_model.kubeflow[0].name : var.model
}
