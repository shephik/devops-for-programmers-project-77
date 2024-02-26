resource "digitalocean_droplet" "droplet1" {
  image  = "ubuntu-20-04-x64"
  name   = "droplet-1"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]
  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file(var.pvt_key)
    timeout     = "2m"
  }
  provisioner "remote-exec" {
    inline = [
      <<EOT
apt -y install docker.io
EOT
    ]
  }
}

resource "digitalocean_droplet" "droplet2" {
  image  = "ubuntu-20-04-x64"
  name   = "droplet-2"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]
  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file(var.pvt_key)
    timeout     = "2m"
  }
  provisioner "remote-exec" {
    inline = [
      <<EOT
apt -y install docker.io
EOT
    ]
  }
}

resource "digitalocean_loadbalancer" "balancer" {
  name   = "loadbalancer-1"
  region = "fra1"

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"
  }

  healthcheck {
    port     = 22
    protocol = "tcp"
  }

  droplet_ids = [digitalocean_droplet.droplet1.id, digitalocean_droplet.droplet2.id]
}