# Terraform Kubernetes AAD Pod Identity

## Introduction

This module deploys and configures Istio on Kubernetes into a Kubernetes Cluster.

## Security Controls

The following security controls can be met through configuration of this template:

* TBD

## Dependancies

* None

## Usage

```terraform
module "kubectl_eck" {
  source = "github.com/canada-ca-terraform-modules/terraform-kubernetes-istio?ref=20190909.1"

  chart_version = "1.1.14"
  dependencies = [
    "${module.namespace_istio_system.depended_on}",
  ]

  helm_service_account = "tiller"
  helm_namespace = "istio-system"
  helm_repository = "istio"

  values = <<EOF

EOF
```

## Variables Values

| Name                 | Type   | Required | Value                                               |
| -------------------- | ------ | -------- | --------------------------------------------------- |
| chart_version        | string | yes      | Version of the Helm Chart                           |
| dependencies         | string | yes      | Dependency name refering to namespace module        |
| helm_service_account | string | yes      | The service account for Helm to use                 |
| helm_namespace       | string | yes      | The namespace Helm will install the chart under     |
| helm_repository      | string | yes      | The repository where the Helm chart is stored       |
| values               | list   | no       | Values to be passed to the Helm Chart               |

## History

| Date     | Release    | Change      |
| -------- | ---------- | ----------- |
| 20190909 | 20190909.1 | 1st release |
