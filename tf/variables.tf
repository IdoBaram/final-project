variable "aws_access_key" {
}

variable "aws_secret_key" {
}

variable "default_keypair_name" {
  default = "linux_internals"
}

variable "monitor_instance_type" {
  default = "t3.small"
}

variable "elk_instance_type" {
  default = "t2.medium"
}

variable "k8_node_instance_type" {
 default = "t2.medium"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "jenkins_agent_servers" {
  default = "2"
}

variable "monitor_servers" {
  default = "1"
}

variable "jenkins_master_servers" {
  default = "1"
}

variable "consul_servers" {
  default = "3"
}

variable "bastion_servers" {
  default = "0"
}

variable "mysql_servers" {
  default = "0"
}

variable "elk_servers" {
  default = "1"
}

variable "owner" {
  default = "Monitoring"
}

variable "vpc_id" {
  default = "vpc-0766b34d92dceda28"
}

variable "public_subnets" {
  default = ["10.1.10.0/24", "10.1.11.0/24"]
}

variable "private_subnets" {
  default = ["10.1.0.0/24", "10.1.1.0/24"]
}

variable "vpc_cidr" {
  default = "10.1.0.0/16"
}

variable "egress_cidr_blocks" {
    default = "0.0.0.0/0"
}

variable "ingress_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [22]
}

variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "availability_zone" {
 default = ["us-east-1a", "us-east-1b"]
}