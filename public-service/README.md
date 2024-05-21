#build docker image
docker build -t public-service-package .  

#run with docker 
docker run public-service-package  

#opening service
minikube service public-service -n assignment
kubectl port-forward service/public-service 7080:8080 -n assignment 

terraform apply --var-file='tfvars/public-service.tfvars'

terraform apply --var-file='tfvars/public-service.tfvars' --auto-approve 
terraform destroy --var-file='tfvars/public-service.tfvars' --auto-approve


kubectl exec -it <pod-name> -n <namespace> -- bash

kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.22/samples/addons/prometheus.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.22/samples/addons/kiali.yaml
