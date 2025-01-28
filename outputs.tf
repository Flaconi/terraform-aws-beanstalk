output "elastic_beanstalk_application_name" {
  value       = module.application.elastic_beanstalk_application_name
  description = "Elastic Beanstalk Application name"
}

output "elastic_beanstalk_environment_hostname" {
  value       = module.environment.hostname
  description = "DNS hostname"
}

output "elastic_beanstalk_environment_id" {
  description = "ID of the Elastic Beanstalk environment"
  value       = module.environment.id
}

output "elastic_beanstalk_environment_name" {
  value       = module.environment.name
  description = "Name"
}

output "elastic_beanstalk_environment_security_group_id" {
  value       = module.environment.security_group_id
  description = "Elastic Beanstalk environment Security Group ID"
}

output "elastic_beanstalk_environment_security_group_arn" {
  value       = module.environment.security_group_arn
  description = "Elastic Beanstalk environment Security Group ARN"
}

output "elastic_beanstalk_environment_security_group_name" {
  value       = module.environment.security_group_name
  description = "Elastic Beanstalk environment Security Group name"
}

output "elastic_beanstalk_environment_elb_zone_id" {
  value       = module.environment.elb_zone_id
  description = "ELB zone id"
}

output "elastic_beanstalk_environment_ec2_instance_profile_role_name" {
  value       = module.environment.ec2_instance_profile_role_name
  description = "Instance IAM role name"
}

output "elastic_beanstalk_environment_tier" {
  description = "The environment tier"
  value       = module.environment.tier
}

output "elastic_beanstalk_environment_application" {
  description = "The Elastic Beanstalk Application specified for this environment"
  value       = module.environment.application
}

output "elastic_beanstalk_environment_endpoint" {
  description = "Fully qualified DNS name for the environment"
  value       = module.environment.endpoint
}

output "elastic_beanstalk_environment_autoscaling_groups" {
  description = "The autoscaling groups used by this environment"
  value       = module.environment.autoscaling_groups
}

output "elastic_beanstalk_environment_launch_configurations" {
  description = "Launch configurations in use by this environment"
  value       = module.environment.launch_configurations
}

output "elastic_beanstalk_environment_load_balancers" {
  description = "Elastic Load Balancers in use by this environment"
  value       = module.environment.load_balancers
}

output "elastic_beanstalk_environment_queues" {
  description = "SQS queues in use by this environment"
  value       = module.environment.queues
}

output "elastic_beanstalk_environment_triggers" {
  description = "Autoscaling triggers in use by this environment"
  value       = module.environment.triggers
}

output "elastic_beanstalk_environment_log_streams" {
  description = "Log Streaming in this environment"
  value       = var.enable_stream_logs
}
