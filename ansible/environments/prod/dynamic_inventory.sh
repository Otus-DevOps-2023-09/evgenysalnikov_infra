#!/bin/sh

if [[ $1 == "--list" ]]; then
  cd ../terraform/prod
  external_ip_address_app=$(terraform show -json | jq '. | .values | .outputs | .external_ip_address_app | .value')
  external_ip_address_db=$(terraform show -json | jq '. | .values | .outputs | .external_ip_address_db | .value')
  cat <<EOT
    {
    "_meta": {
        "hostvars": {}
    },
    "app": {
        "hosts": [$external_ip_address_app],
        "vars": {
            "ansible_user": "ubuntu",
            "ansible_private_key_file": "~/.ssh/terraform"
        }
    },
    "db": {
        "hosts": [$external_ip_address_db],
        "vars": {
            "ansible_user": "ubuntu",
            "ansible_private_key_file": "~/.ssh/terraform"
        }
    }
}
EOT
elif [[ $1 == "--host" ]]; then
  echo '{"_meta": {"hostvars": {}}}' | jq -M
else
  echo '{}'
fi
