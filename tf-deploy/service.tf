resource "kubernetes_service" "public_service_node_port" {
  #count = local.is_public ? 1 : 0
  #for_each = var.api_services
  metadata {
    name = "public-api-nodeport"
    namespace = var.kube_namespace
    labels = {
      app = "public-service"
      name = "public-service-nodeport"

    }
  }
  depends_on = [ kubernetes_deployment.deployment]
  spec {
    type = "NodePort"
    port {
      port        = 8000
      target_port = 8080
      node_port = 30001
      #protocol = "HTTPS"
      name = "http-service"
    }
    selector ={
        app = "public-service"
      }

  }
}

resource "kubernetes_service" "private_service_clusterip" {
  #count = local.is_public ? 1 : 0
  #for_each = var.api_services
  metadata {
    name = "private-api-clusterip"
    namespace = var.kube_namespace
    labels = {
      app = "private-service"
      name = "private-service-clusterip"

    }
  }
  depends_on = [ kubernetes_deployment.deployment]
  spec {
    type = "ClusterIP"
    port {
      port        = 8000
      target_port = 8080
      name = "http-service"
    }
    selector ={
        app = "private-service"
      }

  }
}
