provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.10"
}

module "eks" {
  source                 = "terraform-aws-modules/eks/aws"
  cluster_name           = local.cluster_name
  vpc_id                 = aws_vpc.vpc1.id
  subnets                = aws_subnet.public.*.id
  
  tags = {
    Environment = "final project"
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
    Owner         = data.aws_caller_identity.current.account_id
    Purpose       = local.purpose
  }

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = var.k8_node_instance_type
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 2
      additional_security_group_ids = [aws_security_group.k8s.id, aws_security_group.internal.id]
    }
  ]
}