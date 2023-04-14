#!/bin/bash

# provision
adduser yc-user
mkdir -p /home/yc-user/.ssh
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDlTitTuai/Es1DqcywBZDDOL1dSzfDomvyOfaobqdXnIX3ufDicjXjYkzkozk38JpCz/onir3Uw9Q/BgWMyQ5ZXx9nGC1B68NGUnjyKssXqcgX7Obbme2HxEhwEEwTpPEXNPP8DhSN/ttNs40yjfh/gLCJkE58HdEcGygie2NbG9p4RQLx+bOrnR2slXMuaMa53eqiK2VtMQUH8QGv0ibJ3WRjBthGm0lWJEouIh87yeCkY/wTK072kgF4LYL2cjWEXWixo7sOjjh7Gn13TGAodZySoL0yCkFt5558v7Np8GkfwMH1ZHCLGxIG63Ugt00OeR9jhuhDGf4Gk+JP7WkU0y1I4aQDefuQ2rkitf4zM4AosOW/lIDvWAN2CbLHZ+j9vn5sMPfoIDtm6eUS+ktjZXczCgRZF1dviZ2wuX1v3/J1xg309VSavwjipdHKV5HQMLARFomlvROuimMnxgftMHyHKgi3+mE8QxeUrxLZRM674xLrIwnvlZlNvXq1M6E= dmitrii@ubuntu-shuttle' > /home/yc-user/.ssh/authorized_keys
echo 'yc-user  ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

sudo apt update && sudo apt install -y ruby-full ruby-bundler build-essential mongodb git

cd /home/yc-user && git clone -b monolith https://github.com/express42/reddit.git && cd reddit && bundle install && puma -d
