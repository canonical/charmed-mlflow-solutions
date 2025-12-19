# Charmed MLflow Terraform Solution

This is a Terraform module facilitating the deployment of Charmed MLflow, using the [Terraform juju provider](https://github.com/juju/terraform-provider-juju/). For more information, refer to the provider [documentation](https://registry.terraform.io/providers/juju/juju/latest/docs). 

## API

### Inputs
The solution module offers the following configurable inputs:

| Name                | Type   | Description                             | Required |
|---------------------|--------|-----------------------------------------|----------|
| `<charm_name>_revision`| number | For each charm of the solution, the revision of the charm to deploy | False |
| `risk`| string | Value for the risk to be used. Valid values are (stable, candidate, beta and edge) | False |
| `cos_configuration`| bool | Boolean value that enables COS configuration | False |
| `create_model`       | bool   | Allows skipping Juju model creation and re-using an existing model | False    |
| `enable_mlflow_nodeport` | bool | Boolean value that enables the NodePort service for MLflow | False |
| `existing_opentelemetry_collector_name`| string | Name of an existing opentelemetry-collector-k8s deployment | False |
| `opentelemetry_collector_k8s_size`| string | Grafana agent database storage size | False |
| `mlflow_minio_size`         | string | MinIO storage size allocation            | False    |
| `mlflow_mysql_size`  | string | MySQL storage size allocation for MLflow | False    |
| `mlflow_nodeport` | number | The nodeport for MLflow | False |
| `model`              | string | Name of the Juju model for deployment    | False    |

### Outputs
Upon applying, the solution module exports the following outputs:

| Name                | Description                                                                                            |
|---------------------|--------------------------------------------------------------------------------------------------------|
| `model`             | Model name that Charmed MLflow is deployed on                                                          |
| `opentelemetry_collector_k8s` | Map containing the `app_name`, `provides` and `requires` endpoints of the opentelemetry-collector-k8s charm used |


## Usage

This solution module is intended to be used either on its own or as part of a higher-level module. 

### Create model
If model is created outside of this solution module (ie in a higher-level module), then this should be deployed with `create_model` set to `false`.
```
terraform apply -var create_model=false
```
By default, it is set to `true` in order to enable the Charmed MLflow's standalone deployment. Default value for the `model` is set to `kubeflow` as MLflow is expected to be deployed with Kubeflow which requires `kubeflow` model.

### COS configuration

#### Enable COS configuration
The `cos_configuration` input enables the solution to configure Charmed Kubeflow to integrate with COS. This is done by deploying a `opentelemetry-collector-k8s` charm and adding all the required relations.
```
terraform apply -var cos_configuration=true
```

#### Use an existing opentelemetry-collector-k8s
If there is already an instance of the opentelemetry-collector-k8s charm in the `kubeflow` model, then it can be used instead of deploying a new one. This is achieved with the use of `existing_opentelemetry_collector_name` input. By default, its value is `null`.
```
terraform apply -var cos_configuration=true -var existing_opentelemetry_collector_name="dummy-opentelemetry-collector"
```
> :warning: Setting this input without `cos_configuration` will not have any effect.
