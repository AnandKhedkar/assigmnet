resource "kubernetes_namespace" "istio_system" {
  metadata {
    name = "istio-system"
  }
}

resource "helm_release" "istio_base" {
  name  = "istio-base"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart = "base"

  timeout = 120
  cleanup_on_fail = true
  force_update    = false
  namespace       = kubernetes_namespace.istio_system.metadata.0.name



  #depends_on = [ digitalocean_kubernetes_cluster.my_cluster]
  #for eks clucture make sure clusture is created
}

resource "helm_release" "istiod" {
  name  = "istiod"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart = "istiod"

  timeout = 120
  cleanup_on_fail = true
  force_update    = false
  namespace       = kubernetes_namespace.istio_system.metadata.0.name

  set {
    name = "meshConfig.accessLogFile"
    value = "/dev/stdout"
  }


  depends_on = [  helm_release.istio_base] # digitalocean_kubernetes_cluster.my_cluster,
}

resource "helm_release" "istio_ingress" {
  name  = "istio-ingressgateway"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart = "gateway"

  timeout = 500
  cleanup_on_fail = true
  force_update    = false
  namespace       = kubernetes_namespace.istio_system.metadata.0.name

  depends_on = [  helm_release.istiod] # digitalocean_kubernetes_cluster.my_cluster,
}