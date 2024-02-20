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
    private_key = var.pvt_key
    timeout     = "2m"
  }
  provisioner "remote-exec" {
    inline = [
      <<EOT
curl -fsSL https://get.docker.com -o get-docker.sh \
  sh get-docker.sh 
EOT
    ]
  }
  provisioner "remote-exec" {
    inline = [
      "sudo docker run -d -p 0.0.0.0:80:3000 -e DB_TYPE=postgres -e DB_NAME=wiki -e DB_HOST=db -e DB_PORT=5432 -e DB_USER=kate -e DB_PASS=password ghcr.io/requarks/wiki:2.5",
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
    private_key = var.pvt_key
    timeout     = "2m"
  }
  provisioner "remote-exec" {
    inline = [
      <<EOT
curl -fsSL https://get.docker.com -o get-docker.sh \
  sh get-docker.sh 
EOT
    ]
  }
  provisioner "remote-exec" {
    inline = [
      "sudo docker run -d -p 0.0.0.0:80:3000 -e DB_TYPE=postgres -e DB_NAME=wiki -e DB_HOST=db -e DB_PORT=5432 -e DB_USER=kate -e DB_PASS=password ghcr.io/requarks/wiki:2.5",
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