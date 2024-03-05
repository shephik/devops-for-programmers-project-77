resource "digitalocean_droplet" "droplet1" {
  image  = "ubuntu-20-04-x64"
  name   = var.droplet1_name
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
}

resource "digitalocean_droplet" "droplet2" {
  image  = "ubuntu-20-04-x64"
  name   = var.droplet2_name
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
}

# generate inventory file for Ansible
resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/templates/hosts.tftpl",
    {
      ip_addrs = {
        "host1": digitalocean_droplet.droplet1.ipv4_address, 
        "host2": digitalocean_droplet.droplet2.ipv4_address
      }
    }
  )
  filename = "../ansible/inventory.ini"

  depends_on = [digitalocean_droplet.droplet1, digitalocean_droplet.droplet2]
}

resource "digitalocean_loadbalancer" "balancer" {
  name   = var.balancer_name
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