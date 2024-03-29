# dmzotov-ru_infra
dmzotov-ru Infra repository

## Локальная разработка Ansible ролей с Vagrant. Тестирование конфигурации.
1. Установка **vagrant**
2. Описываем локальную инфраструктуру в **Vagrantfile**
3. Дорабатываем роли и учимся использовать *provisioner*
3. Переделываем *deploy.yml*
4. Проверяем сборку в vagrant
5. Устанавливаем **pip**, а затем с помощью его **virtualenv**
6. Устанавливаем все необходимые пакеты *pip install -r requirements.txt*
7. Создаем заготовку molecule с помощью команды *molecule init scenario --scenario-name default -r db -d vagrant*
8. Добавляем собственнные тесты
9. Собираем и тестируем нашу конфигурацию






## Ansible роли, управление настройками нескольких окружений и best practices

1. Создаем ветку **ansible-3**
2. С помощью **ansible-galaxy** создаем заготовки пол роли
```bash
ansible-galaxy init app
ansible-galaxy init db
```
3. Переводим наши плейбуки в роли
4. Модифицируем плейбуки на запуск ролей
```
---
- name: Configure MongoDB
  hosts: db
  become: true


  roles:
    - db
```
5. Проверяем фунцкионал ролей
```bash
ansible-playbook site.yml
```
6. Модифицируем **ansible.cfg** и вводим переменные окружения для сред **prod** и **stage**
7. Организуем плейбуки согласно **Best Practices**
8. Учимся использовать комьюнити роли на примере **jdauphant.nginx**
9. Учимся использовать **ansible-vault**
10. Проверяем функционал

## Продолжение знакомства с Ansible: templates, handlers, dynamic inventory, vault, tags

1.  Создаем ветку  **ansible-2**
```bash
git checkout -b ansible-1
```
2. Создаем playbook reddit_app.yml заполняем его и тестируем работоспособность
3. Создаем playbook на несколько сценариев reddit_app2.yml
4. Разбиваем наш playbook на несколько: app.yml, db.yml, deploy.yml и переименовываем наши старые playbook-и в **reddit_app_multiple_plays.yml** и **reddit_app_one_play.yml**
5. Модифицируем наши провижионеры в packer, меняеем их на ansible, указываем пути до плейбуков и пересобираем образы, указываем новые образы в переменных для окружения терраформа.

## Управление конфигурацией. Знакомство с Ansible
1. Создаем ветку **ansible-1**
```
git checkout -b ansible-1
```
2. Выполняем установку Ansible (В случае если ранее не был установлен)
3. Создаем каталог **ansible** в репозитории.
4. Поднимаем окружение stage из домашнего задания terraform-2 с помощью команды **terraform apply**
5. Создадим и заполним файл inventory по шаблону на основе вывода outputs terraform.
6. Проверяем доступность сервера командой
```
ansible appserver -i ./inventory -m ping
```
7. Создадим ansible.cfg
```
[defaults]
inventory            = ./inventory.json
remote_user           = ubuntu
private_key_file     = ~/.ssh/id_rsa
host_key_checking    = False
retry_files_enabled  = False
```
8. Создадим inventory.yml
```
app:
  hosts:
    appserver:
      ansible_host: 51.250.85.240

db:
  hosts:
    dbserver:
      ansible_host: 158.160.61.61
```
9. Пишем playbook clone.yml
```
---
- name: Clone
  hosts: app
  tasks:
    - name: Clone repo
      git:
        repo: https://github.com/express42/reddit.git
        dest: /home/ubuntu/reddit
```
10. При первом выполнение playbook мы видим статус CHANGED для таски в playbookе. При повторном использовании playbook статус будет отображаться как OK. Это называется идемпотентностью.



## Принципы организации инфраструктурного кода
1. Создаем ветку **terraform-2**
2. Переносим lb.tf
3. Создадим ресурсы сети и подсети
```
resource "yandex_vpc_network" "app-network" {
  name = "reddit-app-network"
}

resource "yandex_vpc_subnet" "app-subnet" {
  name           = "reddit-app-subnet"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.app-network.id}"
  v4_cidr_blocks = ["192.168.10.0/24"]
}
```
4. Подготовим шаблоны для Packer (app.json и db.json) и создадим образы
5. Вносим правки в main.tf, разбив его на части app.tf и db.tf. В отдельный файл перенесем описание сети vpc.tf
6. Задекларируем новые перменные app_disk_image и db_disk_images.
7. Вносим правки в outputs.tf
8. Подготавливаем модульную структуру. Создаем папки modules\app и modules\db. Исправляем outputs, подгружаем подумали командой terraform get и проверяем корректность работы
9. По аналогии подгтовим окружения stage и prod.
10. Добавим s3 object storage в качестве backend для terraform









## Знакомство с Terraform
1. Создаем ветку **terraform-1**
```
git checkout -b terraform-1
```
2. Создадим и подготовим main.tf
3. Создание VM terraform plan / apply
4. Добавление outputs и provision секции.
5. Описание переменных variables.tf
6. Доп задание с network load balancer

## Основные сервисы Yandex Cloud
1. Создаем ветку **cloud-testapp**
```
git checkout -b cloud-testapp
```
2. Создаем VM
```
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --ssh-key ~/.ssh/id_rsa.pub
```
3. Заходим на vm по ssh  и устанавливаем необходимое ПО
```
sudo apt update && sudo apt install -y ruby-full ruby-bundler build-essential mongodb git
```
4. Выполняем деплой приложения
```
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d
```
5. Созданы скриты для автоматизации
```
#!/bin/bash
sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential
```
```
#!/bin/bash
sudo apt update && sudo apt-get install -y mongodb-org
sudo systemctl start mongod && sudo systemctl enable mongod
```
6. Создан общий скрипт
```
#!/bin/bash

# provision
adduser yc-user
mkdir -p /home/yc-user/.ssh
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDlTitTuai/Es1DqcywBZDDOL1dSzfDomvyOfaobqdXnIX3ufDicjXjYkzkozk38JpCz/onir3Uw9Q/BgWMyQ5ZXx9nGC1B68NGUnjyKssXqcgX7Obbme2HxEhwEEwTpPEXNPP8DhSN/ttNs40yjfh/gLCJkE58HdEcGygie2NbG9p4RQLx+bOrnR2slXMuaMa53eqiK2VtMQUH8QGv0ibJ3WRjBthGm0lWJEouIh87yeCkY/wTK072kgF4LYL2cjWEXWixo7sOjjh7Gn13TGAodZySoL0yCkFt5558v7Np8GkfwMH1ZHCLGxIG63Ugt00OeR9jhuhDGf4Gk+JP7WkU0y1I4aQDefuQ2rkitf4zM4AosOW/lIDvWAN2CbLHZ+j9vn5sMPfoIDtm6eUS+ktjZXczCgRZF1dviZ2wuX1v3/J1xg309VSavwjipdHKV5HQMLARFomlvROuimMnxgftMHyHKgi3+mE8QxeUrxLZRM674xLrIwnvlZlNvXq1M6E= dmitrii@ubuntu-shuttle' > /home/yc-user/.ssh/authorized_keys
echo 'yc-user  ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

sudo apt update && sudo apt install -y ruby-full ruby-bundler build-essential mongodb git

cd /home/yc-user && git clone -b monolith https://github.com/express42/reddit.git && cd reddit && bundle install && puma -d
```
7. Проверка ДЗ
```
testapp_IP = 51.250.93.252
testapp_port = 9292
```

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
