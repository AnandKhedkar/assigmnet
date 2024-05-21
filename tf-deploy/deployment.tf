

resource "kubernetes_deployment" "deployment" {
  for_each = var.api_services
  metadata {
    name = each.value
    namespace = var.kube_namespace
    labels = {
      app = each.value
      name = "${each.value}-deployment"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = each.value
      }
    }
    template {
      metadata {
        labels = {
          app = each.value
        }
      }
      spec {
        container {
          image = "public.ecr.aws/t3o5y1z6/${each.value}:${var.app_version}"
          name  = each.value

        }
      }
    }

  }
}