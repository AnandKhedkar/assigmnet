resource "aws_ecrpublic_repository" "ecr_repo" {

  repository_name = each.value
  for_each = var.api_services
  catalog_data {
    #about_text        = "About Text"
    architectures = ["ARM"]
    #description       = "Description"
    #logo_image_blob   = filebase64(image.png)
    operating_systems = ["Linux"]
    #usage_text        = "Usage Text"
  }
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    env = "test"
  }
}
resource "kubernetes_namespace" "assignment" {
  metadata {
    name = var.kube_namespace
    labels = {
      istio-injection = "enabled"

    }
  }

}

data "external" "build" {
  depends_on = [aws_ecrpublic_repository.ecr_repo]
  program    = ["bash", "../${each.value}/ci.sh"]
  for_each = var.api_services
  query = {
    # arbitrary map from strings to strings, passed
    # to the external program as the data query.
    version = var.app_version

    baz = "def456"
  }


}