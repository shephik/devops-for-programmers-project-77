variable "do_token" {
  description = "DigitalOcean API"
  type = string
  sensitive = true
}

variable "pvt_key" {
  description = "Private SSH key"
  type = string
  sensitive = true
  default = file("~/.ssh/id_rsa")
}