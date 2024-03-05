provider "datadog" {
  api_url = var.datadog_api_url
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

resource "datadog_monitor" "network_monitor" {
  name               = "network_monitor"
  type               = "service check"
  message            = "Problems with network"
  escalation_message = "Alarm"

  query = "'http.can_connect'.over('instance:${var.instance_name}','url:${var.my_site}').by('*').last(2).count_by_status()"

  monitor_thresholds {
    warning           = 1
    warning_recovery  = 1
    critical          = 1
    critical_recovery = 1
  }
}

resource "datadog_monitor" "ssl_network_monitor" {
  name               = "ssl_network_monitor"
  type               = "service check"
  message            = "Problems with ssl network"
  escalation_message = "Alarm"

  query = "'http.ssl_cert'.over('instance:${var.instance_name}_https','url:${var.my_site_https}').by('*').last(2).count_by_status()"

  monitor_thresholds {
    warning           = 1
    warning_recovery  = 1
    critical          = 1
    critical_recovery = 1
  }
}