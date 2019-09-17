# Part of a hack for module-to-module dependencies.
# https://github.com/hashicorp/terraform/issues/1178#issuecomment-449158607
# and
# https://github.com/hashicorp/terraform/issues/1178#issuecomment-473091030
# Make sure to add this null_resource.dependency_getter to the `depends_on`
# attribute to all resource(s) that will be constructed first within this
# module:
resource "null_resource" "dependency_getter" {
  triggers = {
    my_dependencies = "${join(",", var.dependencies)}"
  }
}

resource "null_resource" "istio-init-wait" {
  depends_on = ["null_resource.dependency_getter"]

  provisioner "local-exec" {
    command = "kubectl -n ${var.helm_namespace} wait --for condition=complete job/istio-init-crd-10 --timeout=30s"
  }

  provisioner "local-exec" {
    command = "kubectl -n ${var.helm_namespace} wait --for condition=complete job/istio-init-crd-11 --timeout=30s"
  }

  provisioner "local-exec" {
    command = "kubectl -n ${var.helm_namespace} wait --for condition=complete job/istio-init-crd-12 --timeout=30s"
  }

  triggers = {
    wait_for = "${helm_release.istio-init.id}"
  }
}

resource "helm_release" "istio-init" {
  depends_on = ["null_resource.dependency_getter"]
  name = "istio-init"
  repository = "${var.helm_repository}"
  chart = "istio-init"
  version = "${var.chart_version}"
  namespace = "${var.helm_namespace}"
  timeout = 1200
  wait = true
}

resource "helm_release" "istio" {
  depends_on = ["null_resource.istio-init-wait", "null_resource.dependency_getter"]
  name = "istio"
  repository = "${var.helm_repository}"
  chart = "istio"
  version = "${var.chart_version}"
  namespace = "${var.helm_namespace}"
  timeout = 1200

  values = [
    "${var.values}",
  ]
}

resource "null_resource" "istio-dr" {

  provisioner "local-exec" {
    command = "kubectl -n ${var.helm_namespace} apply -f ${"${path.module}/config/istio/dr/grafana.yml"}"
  }

  provisioner "local-exec" {
    command = "kubectl -n ${var.helm_namespace} apply -f ${"${path.module}/config/istio/dr/kiali.yml"}"
  }

  depends_on = [
    "null_resource.istio-init-wait",
    "null_resource.dependency_getter",
  ]
}

resource "kubernetes_secret" "kiali" {
  metadata {
    name = "kiali"
    namespace = "${var.helm_namespace}"
  }

  data = {
    username = "${var.kiali_username}"
    passphrase = "${var.kiali_password}"
  }
}

# Part of a hack for module-to-module dependencies.
# https://github.com/hashicorp/terraform/issues/1178#issuecomment-449158607
resource "null_resource" "dependency_setter" {
  # Part of a hack for module-to-module dependencies.
  # https://github.com/hashicorp/terraform/issues/1178#issuecomment-449158607
  # List resource(s) that will be constructed last within the module.
  depends_on = [
    "helm_release.istio",
    "helm_release.istio-init",
    "null_resource.istio-dr",
  ]
}
