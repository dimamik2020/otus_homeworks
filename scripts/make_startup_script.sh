#!/bin/bash
cat gcloud_firewall_allow_9292.sh gcloud_run.sh install_ruby.sh install_mongodb.sh deploy.sh > startup.sh
chmod +x startup.sh
