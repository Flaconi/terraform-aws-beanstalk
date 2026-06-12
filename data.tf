data "aws_elastic_beanstalk_solution_stack" "this" {
  most_recent = var.solution_stack_most_recent
  name_regex  = var.solution_stack_name_regex
}

data "aws_route53_zone" "parent" {
  count        = length(local.hostnames)
  name         = local.host_to_zone[local.hostnames[count.index]]
  private_zone = false
}

data "aws_route53_zone" "selected" {
  count        = var.domain_name != "" ? 1 : 0
  name         = var.domain_name
  private_zone = false
}

data "aws_route53_zone" "additional" {
  count        = length(var.subject_alternative_names)
  name         = local.host_to_zone[var.subject_alternative_names[count.index]]
  private_zone = false
}
