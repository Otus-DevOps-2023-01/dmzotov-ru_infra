# dmzotov-ru_infra
dmzotov-ru Infra repository

###  Подключение в одну команду:
```bash
ssh -i ~/.ssh/appuser -J appuser@51.250.70.204 appuser@192.168.0.25 
```

### Подключеие при использовании короткой команды _ssh someinternalhost:_
```bash
cat <<EOF> ~/.ssh/config
Host someinternalhost
    HostName 192.168.0.25
    User appuser
    ProxyJump appuser@51.250.70.204
    IdentityFIle ~/.ssh/appuser
EOF
```

### Данные для подключения
bastion_IP = 51.250.70.204  
someinternalhost_IP = 192.168.0.25
