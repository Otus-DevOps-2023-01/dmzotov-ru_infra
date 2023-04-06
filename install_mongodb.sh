#!/bin/bash
sudo apt update && sudo apt-get install -y mongodb-org
sudo systemctl start mongod && sudo systemctl enable mongod
