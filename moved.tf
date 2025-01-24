moved {
  from = module.elastic_beanstalk_application
  to   = module.application
}

moved {
  from = module.elastic_beanstalk_environment
  to   = module.environment
}

moved {
  from = aws_route53_record.validation
  to   = module.acm.aws_route53_record.validation
}

moved {
  from = aws_acm_certificate_validation.this
  to   = module.acm.aws_acm_certificate_validation.this[0]
}
