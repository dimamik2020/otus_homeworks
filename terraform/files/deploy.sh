#!/bin/bash
set -e

APP_DIR=${1:-$HOME}

# #added rm -rf
# rm -rf $APP_DIR/reddit
# rmdir $APP_DIR/reddit

git clone -b monolith https://github.com/express42/reddit.git $APP_DIR/reddit
cd $APP_DIR/reddit
bundle install

#added -f flag to overwrite files created before 
sudo mv -f /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl start puma
sudo systemctl enable puma
