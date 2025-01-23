variable "region" {
  type        = string
  description = "AWS region"
}

variable "description" {
  type        = string
  description = "Short description of the Environment"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

variable "loadbalancer_type" {
  type        = string
  default     = "application"
  description = "Load Balancer type, e.g. 'application' or 'classic'"
}

variable "loadbalancer_ssl_policy" {
  type        = string
  default     = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  description = "Specify a security policy to apply to the listener. This option is only applicable to environments with an application load balancer"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Instances type"
}

variable "healthcheck_url" {
  type        = string
  default     = "/healthz"
  description = "Application Health Check URL. Elastic Beanstalk will call this URL to check the health of the application running on EC2 instances"
}

variable "healthcheck_interval" {
  type        = number
  default     = 15
  description = "The interval of time, in seconds, that Elastic Load Balancing checks the health of the Amazon EC2 instances of your application"
}

variable "healthcheck_timeout" {
  type        = number
  default     = 5
  description = "The amount of time, in seconds, to wait for a response during a health check. Note that this option is only applicable to environments with an application load balancer"
}

variable "health_streaming_enabled" {
  type        = bool
  default     = false
  description = "For environments with enhanced health reporting enabled, whether to create a group in CloudWatch Logs for environment health and archive Elastic Beanstalk environment health data. For information about enabling enhanced health, see aws:elasticbeanstalk:healthreporting:system."
}

variable "health_streaming_delete_on_terminate" {
  type        = bool
  default     = false
  description = "Whether to delete the log group when the environment is terminated. If false, the health data is kept RetentionInDays days."
}

variable "health_streaming_retention_in_days" {
  type        = number
  default     = 7
  description = "The number of days to keep the archived health data before it expires."
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of subnets"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of subnets"
}

variable "autoscale_min" {
  type        = number
  description = "Minumum instances to launch"
  default     = 1
}

variable "autoscale_max" {
  type        = number
  description = "Maximum instances to launch"
  default     = 1
}

variable "solution_stack_name" {
  type        = string
  description = "Elastic Beanstalk stack, e.g. Docker, Go, Node, Java, IIS. For more info, see https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html"
}

variable "application_name" {
  type = string
}

variable "env_vars" {
  type        = map(string)
  default     = {}
  description = "Map of custom ENV variables to be provided to the application running on Elastic Beanstalk, e.g. env_vars = { DB_USER = 'admin' DB_PASS = 'xxxxxx' }"
}

variable "dns_zone_id" {
  type        = string
  default     = ""
  description = "Route53 parent zone ID. The module will create sub-domain DNS record in the parent zone for the EB environment"
}

variable "domain_name" {
  type    = string
  default = ""
}

variable "dns_subdomain" {
  type        = string
  default     = ""
  description = "The subdomain to create on Route53 for the EB environment. For the subdomain to be created, the `dns_zone_id` variable must be set as well"
}

variable "deployment_version" {
  type    = string
  default = "initial"
}

variable "deployment_bucket" {
  type    = string
  default = null
}

variable "deployment_file_path" {
  type    = string
  default = "Dockerrun.aws.json"
}

variable "deployment_definition" {
  type    = string
  default = null
}

variable "tags" {
  description = "A map of additional tags to apply to all VPC resources"
  type        = map(string)
  default     = {}
}

variable "subject_alternative_names" {
  type    = list(string)
  default = []
}

variable "validation_allow_overwrite_records" {
  type    = bool
  default = true
}

variable "additional_settings" {
  type = list(object({
    namespace = string
    name      = string
    value     = string
  }))

  default     = []
  description = "Additional Elastic Beanstalk settings. For full list of options, see https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/command-options-general.html"
}

variable "managed_actions_enabled" {
  type        = bool
  default     = false
  description = "Enable managed platform updates. When you set this to true, you must also specify a `PreferredStartTime` and `UpdateLevel`"
}

variable "preferred_start_time" {
  type        = string
  default     = "Sun:10:00"
  description = "Configure a maintenance window for managed actions in UTC"
}

variable "update_level" {
  type        = string
  default     = "minor"
  description = "The highest level of update to apply with managed platform updates"
}

variable "enable_stream_logs" {
  type        = bool
  default     = false
  description = "Whether to create groups in CloudWatch Logs for proxy and deployment logs, and stream logs from each instance in your environment"
}

variable "logs_delete_on_terminate" {
  type        = bool
  default     = false
  description = "Whether to delete the log groups when the environment is terminated. If false, the logs are kept RetentionInDays days"
}

variable "logs_retention_in_days" {
  type        = number
  default     = 7
  description = "The number of days to keep log events before they expire."
}

variable "keypair" {
  type        = string
  description = "Name of SSH key that will be deployed on Elastic Beanstalk and DataPipeline instance. The key should be present in AWS"
  default     = ""
}

variable "additional_security_group_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    type        = string
    cidr_blocks = list(string)
    description = optional(string)
  }))
  default     = []
  description = "A list of Security Group rule objects to add to the created security group, in addition to the ones this module normally creates."
}
