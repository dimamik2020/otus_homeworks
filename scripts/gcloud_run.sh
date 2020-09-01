#!/bin/bash

gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image=$PACKER_BUILD \
  --machine-type=f1-micro \
  --tags puma-server \
  --restart-on-failure \

