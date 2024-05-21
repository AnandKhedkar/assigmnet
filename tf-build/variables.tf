variable "kube_namespace" {
  default = "assignment"

}

variable "app_version" {
  type = string
}
variable "ecr_url"{
  default = "public.ecr.aws/t3o5y1z6/"
} 
variable "api_services" {
  type = set(string)
  default = [
    "public-service",
    "private-service"
  ]

}
variable "api_service" {
  type = set(object ({
    name = string,
    kube_namespace = string
  }))
  default = [
    {
      name           = "private-service"
      kube_namespace = "assignment"
      # is_public      = false
      # short_name     = "private"
      # ecr_repo       = "public.ecr.aws/t3o5y1z6/public-service"
    }
    # {
    #   name           = "public-service"
    #   kube_namespace = "assignment"
    #   is_public      = true
    #   short_name     = "public"
    #   ecr_repo       = "public.ecr.aws/t3o5y1z6/public-service"
    # },
  ]

}


# variable "env" {
#   type = object({
#     public = object({
#       kube_namespace = string
#       is_public = bool
#       service_name = string
#       image = string
#     })
#     private = object({
#       kube_namespace = "assignment"
#       is_public = false
#       service_name = "private-service"
#       image = "public.ecr.aws/t3o5y1z6/private-service"
#     })
#   })
#   default = {
#     public = {
#       kube_namespace = "assignment"
#       is_public = true
#       service_name = "public-service"
#       image = "public.ecr.aws/t3o5y1z6/public-service"
#     }
#     private = {

#     }
#   }
# }
