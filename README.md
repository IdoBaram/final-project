# final-project
Thie project builds a small prod like environment, which includes these componenets:
- Jenkins master server
- Jenknis agents
- Consul master cluster
- Promethues and Grafana services
- Elasticsearch services
- MySQL

## pre-requisites:
In order to run this projec, you will need the programs installed:
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html)
- [Helm](https://helm.sh/docs/intro/install/)

## executing the project:
run these command:
```
$ cd  ./tf
$ terraform plan
$ terraform apply -auto-approve
```

Then:
```
$ cd ../ansible
$ ./run_ansible_playbook.sh
```

In order to install consul for K8s run:
```
$ cd ..
$ ./consul helm.sh
```

As soon as you will have that, you will need to:
- Manually create the pipeline in the jenkins master
- Configure the right credentials (DockerHub,GitHub) 
- Set the jenkins agent connection.

## destroying the project:
In order to delete all the componenets created by this project, ececute this command:
```
$ cd  ./tf
$ terraform destroy -auto-approve
```