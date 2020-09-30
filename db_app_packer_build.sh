#!/bin/bash
export DB_PACKER_BUILD="db-reddit-base-`date +%s`"
export APP_PACKER_BUILD="app-reddit-base-`date +%s`"
echo $DB_PACKER_BUILD
echo $APP_PACKER_BUILD
packer build ./packer/db.json
packer build ./packer/app.json
