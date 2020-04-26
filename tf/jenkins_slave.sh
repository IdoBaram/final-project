#!/usr/bin/env bash

apt-get update -y
apt-get install default-jre -y
apt-get install default-jdk -y
apt-get install docker.io -y
systemctl start docker
systemctl enable docker
usermod -aG docker ubuntu
chmod 666 /var/run/docker.sock
apt-get install -y apt-transport-https gnupg2
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
apt-get update -y
apt-get install -y kubectl
curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator
chmod +x ./aws-iam-authenticator
mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$PATH:$HOME/bin
# apt-get install awscli -y