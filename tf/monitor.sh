#!/usr/bin/env bash

git clone https://github.com/IdoBaram/opsschool-monitoring.git /home/ubuntu/monitor
chmod +x /home/ubuntu/monitor/setup/*
/home/ubuntu/monitor/setup/inst_docker.sh
cd /home/ubuntu/monitor/compose
sudo docker-compose up -d