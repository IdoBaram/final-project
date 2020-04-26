aws eks --region us-east-1 update-kubeconfig --name final_course_eks
kubectl create secret generic consul-gossip-encryption-key --from-literal=key="uDBV4e+LbFW3019YKPxIrg=="
git clone https://github.com/IdoBaram/consul-helm.git /home/ubuntu/
cd /home/ubuntu/
helm install hashicorp ./consul-helm
kubectl edit configmap coredns -n  kube-system