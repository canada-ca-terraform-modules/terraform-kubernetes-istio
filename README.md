# Terraform Kubernetes Istio

## Introduction

This module deploys and configures Istio inside a Kubernetes Cluster.

## Security Controls

The following security controls can be met through configuration of this template:

* TBD

## Dependencies

* None

## Optional (depending on options configured):

* None

## Usage

```terraform
module "helm_istio" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-kubernetes-istio.git?ref=v2.0.0"

  chart_version = "1.4.9"
  dependencies = [
    "${module.namespace_istio_system.depended_on}",
  ]

  helm_namespace = "istio-system"
  helm_repository = "istio"

  values = <<EOF

EOF

  enable_cni = true
  cni_values = <<EOF

EOF
```

## Variables Values

| Name                 | Type    | Required | Value                                               |
| -------------------- | ------- | -------- | --------------------------------------------------- |
| chart_version        | string  | yes      | Version of the Helm Chart                           |
| dependencies         | string  | yes      | Dependency name refering to namespace module        |
| helm_service_account | string  | yes      | The service account for Helm to use                 |
| helm_namespace       | string  | yes      | The namespace Helm will install the chart under     |
| helm_repository      | string  | yes      | The repository where the Helm chart is stored       |
| values               | string  | no       | Values to be passed to the Helm Chart               |
| enable_cni           | boolean | no       | Boolean which toggles Istio CNI Plugin installation |
| cni_values           | string  | no       | Values to be passed to the Helm Chart for the CNI   |

## History

| Date     | Release | Change                                            |
| -------- | ------- | ------------------------------------------------- |
| 20200525 | v1.0.0  | 1st release                                       |
| 20200602 | v1.0.1  | Update to module to allow for installation of CNI |
| 20200620 | v2.0.0  | Update to module to use Helm3                     |
