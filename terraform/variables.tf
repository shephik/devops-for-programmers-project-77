variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "pvt_key" {
  description = "Private SSH key"
  type        = string
  sensitive   = true
}

variable "datadog_api_url" {
  description = "DataDog API url"
  type        = string
}

variable "datadog_api_key" {
  description = "DataDog API key"
  type        = string
  sensitive   = true
}

# variable "datadog_app_key" {
#   description = "DataDog APP key"
#   type        = string
# }

variable "my_site" {
  description = "My site address"
  type        = string
}

variable "my_site_https" {
  description = "My site address with ssl"
  type        = string
}

variable "instance_name" {
  description = "My site instance name"
  type        = string
}