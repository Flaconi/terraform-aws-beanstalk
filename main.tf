module "elastic_beanstalk_application" {
  source = "cloudposse/elastic-beanstalk-application/aws"
  # Cloud Posse recommends pinning every module to a specific version
  version = "0.11.1"

  name        = var.application_name
  description = "Test Elastic Beanstalk application"

  tags = var.tags
}

module "elastic_beanstalk_environment" {
  source  = "cloudposse/elastic-beanstalk-environment/aws"
  version = "0.46.0"

  depends_on = [
    aws_elastic_beanstalk_application_version.default,
    aws_acm_certificate_validation.this,
  ]

  name        = var.application_name
  description = var.description
  region      = var.region

  version_label = aws_elastic_beanstalk_application_version.default.id

  elastic_beanstalk_application_name = var.application_name

  autoscale_min = var.autoscale_min
  autoscale_max = var.autoscale_max

  vpc_id = var.vpc_id

  application_subnets = var.private_subnet_ids

  loadbalancer_subnets         = var.public_subnet_ids
  loadbalancer_type            = var.loadbalancer_type
  loadbalancer_certificate_arn = module.acm.acm_certificate_arn
  loadbalancer_ssl_policy      = var.domain_name != "" ? "ELBSecurityPolicy-2016-08" : var.loadbalancer_ssl_policy

  instance_type = var.instance_type

  healthcheck_url      = var.healthcheck_url
  healthcheck_interval = var.healthcheck_interval

  allow_all_egress = true

  solution_stack_name = var.solution_stack_name
  env_vars            = var.env_vars

  prefer_legacy_ssm_policy     = false
  prefer_legacy_service_policy = false

  dns_zone_id   = var.domain_name != "" ? data.aws_route53_zone.selected.*.id[0] : var.dns_zone_id
  dns_subdomain = var.dns_subdomain

  force_destroy = true

  additional_settings = var.additional_settings

  managed_actions_enabled = var.managed_actions_enabled
  preferred_start_time    = var.preferred_start_time
  update_level            = var.update_level

  tags = var.tags
}

data "aws_iam_policy_document" "minimal_s3_permissions" {
  statement {
    sid = "AllowS3OperationsOnElasticBeanstalkBuckets"
    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation"
    ]
    resources = ["*"]
  }
}

resource "aws_s3_bucket_object" "deployment" {
  bucket  = var.deployment_bucket
  key     = "${var.application_name}-${var.deployment_version}-${var.deployment_file_path}"
  content = var.deployment_definition
}

resource "aws_elastic_beanstalk_application_version" "default" {
  depends_on = [module.elastic_beanstalk_application]

  name        = "${var.application_name}-${var.deployment_version}"
  application = var.application_name
  description = "application version created by terraform"
  bucket      = var.deployment_bucket
  key         = aws_s3_bucket_object.deployment.id
}

data "aws_route53_zone" "parent" {
  count        = length(local.hostnames)
  name         = replace(local.hostnames[count.index], local.host_to_zone_regex, "$1")
  private_zone = false
}

resource "aws_route53_record" "validation" {
  depends_on = [module.acm]

  count = length(local.hostnames)

  zone_id         = local.validation_zone_mapping[module.acm.acm_certificate_domain_validation_options[count.index]["domain_name"]]
  name            = module.acm.acm_certificate_domain_validation_options[count.index]["resource_record_name"]
  type            = module.acm.acm_certificate_domain_validation_options[count.index]["resource_record_type"]
  records         = [module.acm.acm_certificate_domain_validation_options[count.index]["resource_record_value"]]
  ttl             = 60
  allow_overwrite = var.validation_allow_overwrite_records
}

data "aws_route53_zone" "selected" {
  count        = var.domain_name != "" ? 1 : 0
  name         = var.domain_name
  private_zone = false
}

module "acm" {
  source = "github.com/terraform-aws-modules/terraform-aws-acm.git?ref=v3.2.0"

  validate_certificate = false
  create_certificate   = var.domain_name != "" ? true : false

  domain_name               = var.dns_subdomain
  subject_alternative_names = var.subject_alternative_names

}

data "aws_route53_zone" "additional" {
  count        = length(var.subject_alternative_names)
  name         = replace(var.subject_alternative_names[count.index], local.host_to_zone_regex, "$1")
  private_zone = false
}

resource "aws_route53_record" "additional" {

  depends_on = [module.elastic_beanstalk_environment]
  count      = length(var.subject_alternative_names)

  zone_id = data.aws_route53_zone.additional[count.index].zone_id
  name    = var.subject_alternative_names[count.index]
  type    = "A"

  alias {
    name                   = module.elastic_beanstalk_environment.endpoint
    zone_id                = module.elastic_beanstalk_environment.elb_zone_id
    evaluate_target_health = true
  }
}

resource "aws_acm_certificate_validation" "this" {

  certificate_arn         = module.acm.acm_certificate_arn
  validation_record_fqdns = aws_route53_record.validation.*.fqdn
}
