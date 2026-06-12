locals {
  hostnames               = reverse(sort(flatten(concat([var.dns_subdomain], var.subject_alternative_names))))
  validation_zone_mapping = zipmap(local.hostnames, data.aws_route53_zone.parent.*.zone_id)

  # Country-code TLDs whose registrable suffix is composed of two labels
  # (e.g. "co.uk", "co.jp"). For these the hosted zone keeps one extra label
  # compared to single-label TLDs like ".de" or ".com".
  two_label_cctlds = ["ao", "bb", "ca", "ck", "cr", "in", "id", "il", "jp", "nz", "za", "kr", "th", "uk", "ve"]

  # Map every hostname to the name of its parent Route53 hosted zone.
  #
  # The zone keeps the last 3 labels for a normal TLD (e.g.
  # "preview.tagging.example.com" -> "tagging.example.com") and the
  # last 4 labels for a two-label ccTLD (e.g.
  # "preview.tagging.example.co.uk" -> "tagging.example.co.uk"),
  # because for those domains only the longer zone exists.
  host_to_zone = {
    for host in local.hostnames : host => join(".", slice(
      split(".", host),
      # number of labels to keep counted from the end of the hostname
      max(0, length(split(".", host)) - (contains(local.two_label_cctlds, element(split(".", host), length(split(".", host)) - 1)) ? 4 : 3)),
      length(split(".", host)),
    ))
  }
}
