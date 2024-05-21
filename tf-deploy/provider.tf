terraform {

}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "docker-desktop"
}

provider "aws" {
  region = "us-east-1"
}

provider "helm" {
   kubernetes {
    config_path = "~/.kube/config"
  }
}