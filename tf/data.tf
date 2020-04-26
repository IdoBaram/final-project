data "aws_ami" "ubuntu" {
	most_recent = true
	
	
	filter {
		name   = "name"
		values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
	}
		
	filter {
		name   = "virtualization-type"
		values = ["hvm"]
	}
	
	owners = ["099720109477"] # Canonical
}
data "aws_caller_identity" "current" {}

data "http" "public_ip" {
   url = "https://api.ipify.org"
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

data "aws_availability_zones" "available" {
}

data "aws_iam_role" "jenkins_agent" {
  name = "Jenkins-agent"
}