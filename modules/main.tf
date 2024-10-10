resource "juju_model" "kubeflow" {
  count = var.create_model ? 1 : 0
  name  = var.model
}
