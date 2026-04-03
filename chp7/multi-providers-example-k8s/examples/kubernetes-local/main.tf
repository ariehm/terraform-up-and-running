
module "simple-webapp" {
  source = "../../modules/services/k8s-app"

  name           = "simple-webapp"
  image          = "nginx"
  replicas       = 2
  container_port = 80
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "docker-desktop"
}
