# Terraform Kubernetes Istio

## Introduction

This module deploys and configures Istio inside a Kubernetes Cluster. The deployment of Istio through Helm requires a [Helm2 to be used](https://discuss.istio.io/t/istios-helm-support-in-2020/5535).

## Security Controls

The following security controls can be met through configuration of this template:

* TBD

## Dependencies

* Helm2 capable Terraform Provider (less than v1.0)
* If using more than one version of the Helm provider, a [provider alias](https://www.terraform.io/docs/configuration/providers.html#alias-multiple-provider-instances) can be used.

## Optional (depending on options configured):

* None

## Usage

```terraform
module "helm_istio" {
  source = "github.com/canada-ca-terraform-modules/terraform-kubernetes-istio?ref=v1.1.0"

  # This block can be used to specify an alias for a specifc provider configuration
  providers = {
    helm = "helm.istio"
  }

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

| Name            | Type    | Required | Value                                               |
| --------------- | ------- | -------- | --------------------------------------------------- |
| chart_version   | string  | yes      | Version of the Helm Chart                           |
| dependencies    | string  | yes      | Dependency name refering to namespace module        |
| helm_namespace  | string  | yes      | The namespace Helm will install the chart under     |
| helm_repository | string  | yes      | The repository where the Helm chart is stored       |
| values          | list    | no       | Values to be passed to the Helm Chart               |
| enable_cni      | boolean | no       | Boolean which toggles Istio CNI Plugin installation |
| cni_values      | string  | no       | Values to be passed to the Helm Chart for the CNI   |

## History

| Date     | Release    | Change                                                                      |
| -------- | ---------- | --------------------------------------------------------------------------- |
| 20190729 | 20190729.1 | Improvements to documentation and formatting                                |
| 20190909 | 20190909.1 | 1st release                                                                 |
| 20200525 | v1.0.0     | 1st major version                                                           |
| 20200602 | v1.0.1     | Update to module to allow for installation of CNI                           |
| 20200629 | v1.1.0     | Removed the provider specification to allow it to be injected in the module |