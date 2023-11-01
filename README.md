# evgenysalnikov_infra
evgenysalnikov Infra repository

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
