#!/usr/bin/env bash

cp ../tf/final_project_key.pem ./
cp ../tf/hosts ./
chmod 600 ./final_project_key.pem
ansible-playbook -i ./hosts -u ubuntu ./docker.yaml