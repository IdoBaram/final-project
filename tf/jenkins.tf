resource "aws_instance" "jenkins_master" {
  count                       = var.jenkins_master_servers
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = element(aws_subnet.public.*.id, 1)
  vpc_security_group_ids      = [aws_security_group.jenkins-sg.id, aws_security_group.internal.id]
  key_name                    = local.aws_key_pair
  iam_instance_profile        = local.iam_instance_profile

  tags = {
    Name = "Jenkins Master"
    Owner         = data.aws_caller_identity.current.account_id
    Purpose       = local.purpose
  }
}

resource "aws_instance" "jenkins_agent" {
  ami                    = data.aws_ami.ubuntu.id
  count                  = var.jenkins_agent_servers
  associate_public_ip_address = false
  subnet_id              = element(aws_subnet.public.*.id, count.index)
  instance_type          = var.instance_type
  key_name               = local.aws_key_pair
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id, aws_security_group.internal.id]
  iam_instance_profile   = "Jenkins-agent"
  
  tags = {
    Name = "Jenkins Agent ${count.index+1}"
    Owner         = data.aws_caller_identity.current.account_id
    Purpose       = local.purpose
  }
}

output "jenkins_agent_ip" {
  value = join(",", aws_instance.jenkins_agent.*.public_ip, aws_instance.jenkins_agent.*.private_ip)
}

output "jenkins_master_ip" {
  value = join(",", aws_instance.jenkins_master.*.public_ip, aws_instance.jenkins_master.*.private_ip)
}