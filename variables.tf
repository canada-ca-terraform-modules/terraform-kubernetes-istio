variable "helm_namespace" {}

variable "helm_repository" {}

variable "chart_version" {}

variable "enable_cni" {
  type    = bool
  default = false
}

variable "cni_values" {
  default = ""
}

variable "dependencies" {
  type = "list"
}

variable "values" {
  default = ""
  type    = "string"
}

variable "kiali_username" {
  default = "admin"
}

variable "kiali_password" {
  default = "admin"
}
