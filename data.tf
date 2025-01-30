data "aws_elastic_beanstalk_solution_stack" "this" {
  most_recent = var.solution_stack_most_recent
  name_regex  = var.solution_stack_name_regex
}

data "aws_route53_zone" "parent" {
  count        = length(local.hostnames)
  name         = replace(local.hostnames[count.index], local.host_to_zone_regex, "$1")
  private_zone = false
}

data "aws_route53_zone" "selected" {
  count        = var.domain_name != "" ? 1 : 0
  name         = var.domain_name
  private_zone = false
}

data "aws_route53_zone" "additional" {
  count        = length(var.subject_alternative_names)
  name         = replace(var.subject_alternative_names[count.index], local.host_to_zone_regex, "$1")
  private_zone = false
}
