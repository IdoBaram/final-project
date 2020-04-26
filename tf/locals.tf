locals {
  jenkins_default_name = "jenkins"
}

locals {
  my_ip = "${data.http.public_ip.body}/32"
}

locals {
  purpose = "OpsSchool training"
}

locals {
  cluster_name = "final_course_eks"
}

locals {
  aws_key_pair = aws_key_pair.final_project_key.key_name
}

locals {
  iam_instance_profile = aws_iam_instance_profile.consul-join.name
}

locals {
  aws_vpc = aws_vpc.vpc1.id
}

locals {
  bastion_sg = aws_security_group.bastion_sg.id
}