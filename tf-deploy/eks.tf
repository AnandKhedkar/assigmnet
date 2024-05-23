module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.5"

  cluster_name    = local.cluster_name
  cluster_version = "1.29"

  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true

#   cluster_addons = {
#     aws-ebs-csi-driver = {
#       service_account_role_arn = module.irsa-ebs-csi.iam_role_arn
#     }
#   }

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"

  }

  eks_managed_node_groups = {
    service-nodes = {
      name = "node-group-1"

      instance_types = ["t2.micro"]

      min_size     = 1
      max_size     = 1
      desired_size = 1

    }
  }
}

resource "kubernetes_ingress_class" "ingress-alb" {
  metadata {
    name = "ingress-alb"
  }

  spec {
    controller = "ingress.k8s.aws/alb"
    # parameters {
    #   api_group = "k8s.example.com"
    #   kind      = "IngressParameters"
    #   name      = "external-lb" #if does not work think of annotations https://registry.terraform.io/providers/hashicorp/kubernetes/2.28.1/docs/resources/annotations
    # }
  }
}
