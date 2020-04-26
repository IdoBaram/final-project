#Monitoring Security Group
resource "aws_security_group" "monitor_sg" {
  name        = "monitor_sg"
  description = "Security group for monitoring server"
  vpc_id      = local.aws_vpc
  tags = {
    Name      = "opsschool_monitoring_sg"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.egress_cidr_blocks]
    description = "Allow all outside security group"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
    description = "Allow all inside security group"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups = [aws_security_group.consul-sg.id]
    description = "Allow all inside security group"
  }

  # Allow ICMP from control host IP
  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = [local.my_ip]
  }

  # Allow all SSH External
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = [local.my_ip]
    description = "Allow ssh from the local IP"
  }

  # Allow all traffic to HTTP port 3000
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "TCP"
    cidr_blocks = [local.my_ip]
    description = "Allow Grafana UI access from local IP"
  }

  # Allow all traffic to HTTP port 9090
  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "TCP"
    cidr_blocks = [local.my_ip]
    description = "Allow Promethues UI access from local IP"
  }
}

resource "aws_security_group" "consul-sg" {
  name        = "opsschool-consul"
  vpc_id      = local.aws_vpc
  description = "Allow ssh & consul inbound traffic"
  tags = {
    Name      = "opsschool_consul_sg"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
    description = "Allow all inside security group"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.my_ip]
    description = "Allow ssh from the local IP"
  }

  ingress {
    from_port   = 8500
    to_port     = 8500
    protocol    = "tcp"
    cidr_blocks = [local.my_ip]
    description = "Allow consul UI access from local IP"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.egress_cidr_blocks]
    description = "Allow all outside security group"
  }
}

resource "aws_security_group" "internal" {
  name        = "internal_sg"
  vpc_id      = local.aws_vpc
  description = "Allow ssh & consul inbound traffic"
  tags = {
    Name      = "internal_sg"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
    description = "Allow all inside security group"
  }
}

resource "aws_security_group" "mysql" {
  name        = "mysql_sg"
  vpc_id      = local.aws_vpc
  description = "Allow mysql inbound traffic"
  tags = {
    Name      = "internal_sg"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.egress_cidr_blocks]
    description = "Allow all outside security group"

  }
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.my_ip]
    description = "Allow ssh from the local IP"
  }
}

resource "aws_security_group" "elk" {
  name        = "elk_sg"
  description = "Security group for ELK server"
  vpc_id      = local.aws_vpc
  tags = {
    Name      = "opsschool_elk_sg"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.egress_cidr_blocks]
    description = "Allow all outside security group"
  }

  # Allow ICMP from control host IP
  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = [local.my_ip]
  }

  # Allow all SSH External
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = [local.my_ip]
    description = "Allow ssh from the local IP"
  }

  ingress {
    from_port   = 5601
    to_port     = 5601
    protocol    = "TCP"
    cidr_blocks = [local.my_ip]
    description = "Allow kibana UI access from local IP"
  }

  # Allow all traffic to HTTP port 9090
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "TCP"
    cidr_blocks = [local.my_ip]
    description = "Allow Logstash UI access from local IP"
  }

  ingress {
    from_port   = 9300
    to_port     = 9300
    protocol    = "TCP"
    cidr_blocks = [local.my_ip]
    description = "Allow elk UI access from local IP"
  }

   ingress {
    from_port   = 9200
    to_port     = 9200
    protocol    = "TCP"
    cidr_blocks = [local.my_ip]
    description = "Allow elk UI access from local IP"
  }
}

resource "aws_security_group" "jenkins-sg" {
  name = "jenkins-sg"
  vpc_id      = local.aws_vpc
  description = "Allow Jenkins inbound traffic"

  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = [var.egress_cidr_blocks]
 }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [local.my_ip]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.egress_cidr_blocks]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = [local.my_ip]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.my_ip]
  }

  ingress {
    from_port   = 2375
    to_port     = 2375
    protocol    = "tcp"
    cidr_blocks = [local.my_ip]
  }

  tags = {
    Name = "jenkins-sg"
  }
}

# resource "aws_security_group" "k8s" {
#   name_prefix = "k8s"
#   vpc_id      = local.aws_vpc

#   ingress {
#     from_port = 22
#     to_port   = 22
#     protocol  = "tcp"

#     cidr_blocks = [
#       local.my_ip
#     ]
#   }
#    tags = {
#     Name = "k8s-sg"
#   }
# }

resource "aws_security_group" "bastion_sg" {
  name        = "opsschool-bastion"
  vpc_id      = local.aws_vpc
  description = "Allow ssh & consul inbound traffic"
  tags = {
    Name      = "bastion_sg"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.my_ip]
    description = "Allow ssh from the local IP"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.egress_cidr_blocks]
    description = "Allow all outside security group"
  }
}

resource "aws_security_group_rule" "bastion_sg" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  self              = true
  security_group_id = aws_security_group.jenkins-sg.id
  # "${element(split(",", "${aws_security_group.elk.id}, ${aws_security_group.jenkins-sg.id}"), count.index)}"
  # ["aws_security_group.elk.id", "aws_security_group.jenkins-sg.id"] #, aws_security_group.mysql.id, aws_security_group.monitor_sg.id,
}