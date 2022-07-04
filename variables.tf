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
  default     = ""
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
  description = "Additional Elastic Beanstalk setttings. For full list of options, see https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/command-options-general.html"
}
