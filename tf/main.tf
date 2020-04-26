resource "aws_instance" "Consul_Server" {
    count                  = var.consul_servers
    instance_type          = var.instance_type
    ami          	         = data.aws_ami.ubuntu.id
    vpc_security_group_ids = [aws_security_group.consul-sg.id, aws_security_group.internal.id]
    subnet_id              = element(aws_subnet.public.*.id, count.index)
    key_name               = local.aws_key_pair
    iam_instance_profile   = local.iam_instance_profile
    user_data              = file("consul-server.sh")

  tags = {
    Name          = "Consul Server ${count.index+1}"
    Owner         = data.aws_caller_identity.current.account_id
    Purpose       = local.purpose
    Environment = "final project"
    consul_server = true  
  }
}

resource "aws_instance" "monitoring" {
  count                       = var.monitor_servers
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = element(aws_subnet.public.*.id, count.index)
  ami                         = data.aws_ami.ubuntu.id
  vpc_security_group_ids      = [aws_security_group.monitor_sg.id, aws_security_group.internal.id]
  key_name                    = local.aws_key_pair
  iam_instance_profile        = local.iam_instance_profile

  tags = {
    Name          = "Monitoring"
    Owner         = data.aws_caller_identity.current.account_id
    Purpose       = local.purpose
    Environment = "final project"
  }
}

resource "aws_instance" "elk" {
  count                       = var.elk_servers
  instance_type               = var.elk_instance_type
  associate_public_ip_address = true
  subnet_id                   = element(aws_subnet.public.*.id, count.index)
  ami                         = data.aws_ami.ubuntu.id
  vpc_security_group_ids      = [aws_security_group.elk.id, aws_security_group.internal.id]
  key_name                    = local.aws_key_pair
  iam_instance_profile        = local.iam_instance_profile

  tags = {
    Name          = "ELK"
    Owner         = data.aws_caller_identity.current.account_id
    Purpose       = local.purpose
    Environment = "final project"
  }
}

resource "aws_instance" "mysql" {
  count                       = var.mysql_servers
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = element(aws_subnet.public.*.id, count.index)
  ami                         = data.aws_ami.ubuntu.id
  vpc_security_group_ids      = [aws_security_group.mysql.id, aws_security_group.internal.id]
  key_name                    = local.aws_key_pair
  iam_instance_profile        = local.iam_instance_profile

  tags = {
    Name          = "mysql"
    Owner         = data.aws_caller_identity.current.account_id
    Purpose       = local.purpose
    Environment = "final project"
  }
}

resource "aws_instance" "bastion" {
  count                       = var.bastion_servers
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = element(aws_subnet.public.*.id, count.index)
  ami                         = data.aws_ami.ubuntu.id
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  key_name                    = local.aws_key_pair

  tags = {
    Name          = "bastion"
    Owner         = data.aws_caller_identity.current.account_id
    Purpose       = "OpsSchool training"
    consul_server = true
  }
}

output "bastion" {
  value = join(",", aws_instance.bastion.*.public_ip)
}


output "monitor_server_ip" {
  value = join(",", aws_instance.monitoring.*.public_ip, aws_instance.monitoring.*.private_ip)
}

output "consul_server_ip" {
  value = join(",", aws_instance.Consul_Server.*.public_ip, aws_instance.Consul_Server.*.private_ip)
}

output "elk_public_ip" {
  value = join(",", aws_instance.elk.*.public_ip)
}

output "mysql_public_ip" {
  value = join(",", aws_instance.mysql.*.public_ip)
}