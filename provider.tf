provider "helm" {
  version         = "~> v0.9.1"
  service_account = "${var.helm_service_account}"
  namespace       = "${var.helm_namespace}"
  install_tiller  = "true"
  tiller_image    = "gcr.io/kubernetes-helm/tiller:v2.13.0"

  kubernetes {}
}

provider "helm" {
  version                           = "v1.2.1"
  debug                             = ""
  plugins_path                      = ""
  registry_config_path              = ""
  repository_config_path            = ""
  repository_cache                  = ""
  helm_driver                       = ""

  kubernetes {
    config_path                     = ""                    
    host                            = ""
    username                        = ""
    password                        = ""
    token                           = ""
    insecure                        = ""
    client_certificate              = ""
    client_key                      = ""
    cluster_ca_certificate          = ""
    config_context                  = ""
    load_config_file                = ""

    exec {
      api_version                   = ""
      command                       = ""
      args                          = ""
      env                           = ""
    }
  }
}