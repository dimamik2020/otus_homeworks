#!/bin/bash
apt update
apt install -y ruby-full ruby-bundler build-essential
#!/bin/bash
sudo apt-get install -y gnupg
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt-get -y update
sudo apt-get install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod
#!/bin/bash
cd ~/
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
sudo systemctl start puma
sudo systemctl enable puma

