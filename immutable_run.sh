#!/bin/bash
./scripts/make_startup_script.sh
export PACKER_BUILD="reddit-base-`date +%s`"
##export PACKER_BUILD="reddit-base-1598961395"
echo $PACKER_BUILD
packer build ./packer/ubuntu16.json
./scripts/gcloud_firewall_allow_9292.sh
./scripts/gcloud_run.sh
