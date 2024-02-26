terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      # version = "~> 2.0"
    }
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "terraform" {
  name = "kate-ssh"
}
