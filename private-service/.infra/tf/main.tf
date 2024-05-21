resource "kubernetes_namespace" "example" {
  metadata {
    name = "assignment"
  }
}

resource "kubernetes_deployment" "public-service" {
  metadata {
    name = "public-service"
    labels = {
      name = "public-service"
    }
  }

  spec {
    selector {
        match_labels = {
            name = "public"
        }
    }
    template {
      metadata {
        labels = {
          name = "public"
        }
      }
      spec {
        container {
          image = "public-service-package"
          name  = "public"

        }
      }
    }

  }
}