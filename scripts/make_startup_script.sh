#!/bin/bash
cd ./scripts && cat install_ruby.sh install_mongodb.sh deploy.sh > startup.sh && chmod +x startup.sh
