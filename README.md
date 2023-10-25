# evgenysalnikov_infra
evgenysalnikov Infra repository

## VPN Connection
bastion_IP = bastion.salnikoff.com
someinternalhost_IP = 10.128.0.19

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
    ProxyJump yacloud@158.160.118.143
```
