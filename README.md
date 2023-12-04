# evgenysalnikov_infra
evgenysalnikov Infra repository

## Ansible
### Ansible 2
#### Homework ansible-2
 - создан плейбук site.yml объединяющий в себе несколько ролей для деплоя приложения
 - используется получение адреса хоста с бд из динамического инвентори
 - выполнены задания со *
 - packer использует ansible для создания образов
### Ansible 1
#### Homework ansible-1
`Теперь выполните ansible app -m command -a 'rm -rf ~/reddit' и проверьте еще раз выполнение плейбука. Что изменилось и почему? Добавьте информацию в README.md .`
changed=1 стало 1, было 0. Произошло потому что в этот раз git успешно клонировал репозиторий которого не было.
#### Сделано:
- добавлен просто inventory
- добавлен playbook
- добавлен файл с конфигурацией ansible.cfg
- добавлен inventory файл в формате yml
- добавлен inventory.json
- добавлен скрипт для dynamic inventory - dynamic_inventory.sh


## Terraform

### Terraform 2
- сделано два окружения prod и stage
- логика создания vpc с ruby, mongodb и установкой приложения вынесена в модули
- создан скрипт для создания бакетов для бекенда терраформ
- выполнены все задания со *
  - открывается порт на mongodb
  - IP адрес базы данных используется приложением
  - приложение стартует и работает

### Terraform 1
- создание инстанса reddit-app из базового образа
- создание нескольких инстансов reddit-app указывая их кол-во. По-умолчанию 1
- создание балансировщика смотрящего на reddit-app инстансы

## Reddit APP
testapp_IP = 158.160.125.98

testapp_port = 9292

### Команда для создания VM с последующим запуском приложения
```
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --metadata-from-file user-data=user_metadata.yaml
```

### Сделано
- Создан базовый образ packer/ubuntu.json
- Создан полный образ приложения (приложение сразу запускается) packer/immutable.json
- Переменные вынесены в отдельный файл variables.json
- Создан скрипт создания виртуальной машины с автоматическим запуском приложения

## VPN Connection
bastion_IP = 158.160.126.146
someinternalhost_IP = 10.128.0.33

```
(https://bastion.salnikoff.com/login)
"detail": "Error creating new order :: too many certificates already issued for \"nip.io\". Retry after 2023-10-20T22:00:00Z: see https://letsencrypt.org/docs/rate-limits/",
"status": 429
```



## SSH
### SSH to internal host through bastion
`ssh -i ~/.ssh/yacloud -J yacloud@158.160.118.143 yacloud@10.128.0.19`

### SSH config file ( ~/.ssh/config )
```
Host 10.128.0.*
    IdentityFile ~/.ssh/yacloud
    IdentitiesOnly yes
    HostkeyAlgorithms +ssh-rsa
    PubkeyAcceptedAlgorithms +ssh-rsa
    ProxyJump yacloud@158.160.118.143
```

### SSH host alias config file (  ~/.ssh/config )
```
Host someinternalhost
    HostName 10.128.0.19
    User yacloud
    IdentityFile ~/.ssh/yacloud
    IdentitiesOnly yes
    HostkeyAlgorithms +ssh-rsa
    PubkeyAcceptedAlgorithms +ssh-rsa
    ProxyJump yacloud@158.160.126.146
```
