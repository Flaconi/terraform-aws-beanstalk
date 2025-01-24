module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "5.1.1"

  create_certificate = var.domain_name != "" ? true : false

  validation_method = "DNS"

  domain_name = var.dns_subdomain
  zone_id     = data.aws_route53_zone.selected[0].zone_id

  subject_alternative_names = var.subject_alternative_names
  zones                     = local.validation_zone_mapping

  tags = var.tags
}

module "application" {
  source = "cloudposse/elastic-beanstalk-application/aws"
  # Cloud Posse recommends pinning every module to a specific version
  version = "0.12.0"

  name        = var.application_name
  description = "Test Elastic Beanstalk application"

  tags = var.tags
}

module "environment" {
  source  = "cloudposse/elastic-beanstalk-environment/aws"
  version = "0.51.2"

  depends_on = [
    aws_elastic_beanstalk_application_version.default,
    module.acm,
  ]

  name        = var.application_name
  description = var.description
  region      = var.region

  keypair = var.keypair

  version_label = aws_elastic_beanstalk_application_version.default.id

  elastic_beanstalk_application_name = var.application_name

  autoscale_min = var.autoscale_min
  autoscale_max = var.autoscale_max

  vpc_id = var.vpc_id

  availability_zone_selector = var.availability_zone_selector

  application_subnets = var.private_subnet_ids

  loadbalancer_subnets         = var.public_subnet_ids
  loadbalancer_type            = var.loadbalancer_type
  loadbalancer_certificate_arn = module.acm.acm_certificate_arn
  loadbalancer_ssl_policy      = var.loadbalancer_ssl_policy

  instance_type    = var.instance_type
  root_volume_type = var.root_volume_type

  healthcheck_url                      = var.healthcheck_url
  healthcheck_interval                 = var.healthcheck_interval
  healthcheck_timeout                  = var.healthcheck_timeout
  health_streaming_enabled             = var.health_streaming_enabled
  health_streaming_delete_on_terminate = var.health_streaming_delete_on_terminate
  health_streaming_retention_in_days   = var.health_streaming_retention_in_days

  allow_all_egress = true

  additional_security_group_rules = var.additional_security_group_rules

  solution_stack_name = var.solution_stack_name
  env_vars            = var.env_vars

  prefer_legacy_ssm_policy     = false
  prefer_legacy_service_policy = false

  dns_zone_id   = var.domain_name != "" ? data.aws_route53_zone.selected.*.id[0] : var.dns_zone_id
  dns_subdomain = var.dns_subdomain

  force_destroy = true

  enable_stream_logs       = var.enable_stream_logs
  logs_delete_on_terminate = var.logs_delete_on_terminate
  logs_retention_in_days   = var.logs_retention_in_days

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

resource "aws_s3_object" "deployment" {
  bucket  = var.deployment_bucket
  key     = "${var.application_name}-${var.deployment_version}-${var.deployment_file_path}"
  content = var.deployment_definition
}

resource "aws_elastic_beanstalk_application_version" "default" {
  depends_on = [module.application]

  name        = "${var.application_name}-${var.deployment_version}"
  application = var.application_name
  description = "application version created by terraform"
  bucket      = var.deployment_bucket
  key         = aws_s3_object.deployment.id
}

resource "aws_route53_record" "additional" {
  depends_on = [module.environment]
  count      = length(var.subject_alternative_names)

  zone_id = data.aws_route53_zone.additional[count.index].zone_id
  name    = var.subject_alternative_names[count.index]
  type    = "A"

  alias {
    name                   = module.environment.endpoint
    zone_id                = module.environment.elb_zone_id
    evaluate_target_health = true
  }
}
