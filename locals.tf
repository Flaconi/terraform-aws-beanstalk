locals {
  hostnames               = reverse(sort(flatten(concat([var.dns_subdomain], var.subject_alternative_names))))
  validation_zone_mapping = zipmap(local.hostnames, data.aws_route53_zone.parent.*.zone_id)
  host_to_zone_regex      = "/^(?:.*\\.)?([^.]+\\.[^.]+\\.[^.]+)$/"
}
