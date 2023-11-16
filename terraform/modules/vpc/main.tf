#terraform {
#  required_providers {
#    yandex = {
#      source = "yandex-cloud/yandex"
#    }
#  }
#  required_version = ">= 0.13"
#}

resource "null_resource" "remote-exec-app" {
  connection {
    type        = "ssh"
    host        = var.external_ip_address_app
    user        = "ubuntu"
    agent       = false
    # путь до приватного ключа
    private_key = file(var.app_private_key_path)
  }
  provisioner "file" {
    source      = "../files/puma.service"
    destination = "/tmp/puma.service"
  }
  provisioner "remote-exec" {
    script = "../files/deploy.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo sed -i 's/DATABASE_URL=127.0.0.1/DATABASE_URL=${var.external_ip_address_db}/' /etc/systemd/system/puma.service",
      "sudo systemctl start puma", "sudo systemctl enable puma"
    ]
  }
}

resource "null_resource" "remote-exec-db" {
  connection {
    type        = "ssh"
    host        = var.external_ip_address_db
    user        = "ubuntu"
    agent       = false
    # путь до приватного ключа
    private_key = file(var.app_private_key_path)
  }
  provisioner "remote-exec" {
    script = "../files/mongo_open_port.sh"
  }
}
