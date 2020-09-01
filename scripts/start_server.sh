#!/bin/bash
pwd >> /mylog.log
id >> /mylog.log
sudo su Dima && cd ~/reddit/ && puma -d >> /mylog.log
