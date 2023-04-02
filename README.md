# dmzotov-ru_infra
dmzotov-ru Infra repository

## Play Travis and ChatOps

#### Выполненные работы

1. Создана ветку *play-travis*
```
git checkout -b play-travis
```
2.  Добавлен *PULL_REQUEST_TEMPLATE.md*
```
 cd .github ?? wget http://bit.ly/otus-pr-template -O PULL_REQUEST_TEMPLATE.md
```
4. Коммит
```
git add PULL_REQUEST_TEMPLATE.md
git commit -m 'Add PR template'
git push --set-upstream origin play-travis
```
4. Создан .travis.yml
```
repos:
-   repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v2.3.0
    hooks:
    -   id: end-of-file-fixer
    -   id: trailing-whitespace
```
5. Проверка Github Actions
6. Исправление ошибки
7. PR


## Подготовка базового образа VM при помощи Packer
#### Что было сделано
1. Создана ветка packer-base
2. Установлен packer
3. Создан сервисный аккаунт и предоставлены права Editor
4. Создан шаблон ВМ для образа
5. Выполнена проверка и сборка образа
6. Устранена ошибка с публичный IP-адресом
7. Проверена работоспособность образа
8. Создан gitignore и variables example
9. Создан bake-образ (immutable.json)
10. Проверка образа, создание ВМ, проверка доступности по ssh и публичной ссылке формата https://public_ip:port


## HW cloud1 Bastion, VPN

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
