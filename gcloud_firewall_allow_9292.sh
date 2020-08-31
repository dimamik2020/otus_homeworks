#!/bin/bash
gcloud compute firewall-rules create puma-server \
--allow=tcp:9292 \
--direction=INGRESS \
--source-ranges=0.0.0.0/0 \
--target-tags=puma-server
