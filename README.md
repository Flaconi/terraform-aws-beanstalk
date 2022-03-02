# terraform-module-template
Template for Terraform modules

<!-- Uncomment and replace with your module name
[![lint](https://github.com/flaconi/<MODULENAME>/workflows/lint/badge.svg)](https://github.com/flaconi/<MODULENAME>/actions?query=workflow%3Alint)
[![test](https://github.com/flaconi/<MODULENAME>/workflows/test/badge.svg)](https://github.com/flaconi/<MODULENAME>/actions?query=workflow%3Atest)
[![Tag](https://img.shields.io/github/tag/flaconi/<MODULENAME>.svg)](https://github.com/flaconi/<MODULENAME>/releases)
-->
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

<!-- TFDOCS_HEADER_START -->


<!-- TFDOCS_HEADER_END -->

<!-- TFDOCS_PROVIDER_START -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

<!-- TFDOCS_PROVIDER_END -->

<!-- TFDOCS_REQUIREMENTS_START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |

<!-- TFDOCS_REQUIREMENTS_END -->

<!-- TFDOCS_INPUTS_START -->
## Required Inputs

The following input variables are required:

### <a name="input_region"></a> [region](#input\_region)

Description: AWS region

Type: `string`

### <a name="input_description"></a> [description](#input\_description)

Description: Short description of the Environment

Type: `string`

### <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id)

Description: ID of the VPC

Type: `string`

### <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids)

Description: List of subnets

Type: `list(string)`

### <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids)

Description: List of subnets

Type: `list(string)`

### <a name="input_solution_stack_name"></a> [solution\_stack\_name](#input\_solution\_stack\_name)

Description: Elastic Beanstalk stack, e.g. Docker, Go, Node, Java, IIS. For more info, see https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html

Type: `string`

### <a name="input_application_name"></a> [application\_name](#input\_application\_name)

Description: n/a

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_loadbalancer_type"></a> [loadbalancer\_type](#input\_loadbalancer\_type)

Description: Load Balancer type, e.g. 'application' or 'classic'

Type: `string`

Default: `"application"`

### <a name="input_loadbalancer_ssl_policy"></a> [loadbalancer\_ssl\_policy](#input\_loadbalancer\_ssl\_policy)

Description: Specify a security policy to apply to the listener. This option is only applicable to environments with an application load balancer

Type: `string`

Default: `""`

### <a name="input_healthcheck_url"></a> [healthcheck\_url](#input\_healthcheck\_url)

Description: Application Health Check URL. Elastic Beanstalk will call this URL to check the health of the application running on EC2 instances

Type: `string`

Default: `"/healthz"`

### <a name="input_healthcheck_interval"></a> [healthcheck\_interval](#input\_healthcheck\_interval)

Description: The interval of time, in seconds, that Elastic Load Balancing checks the health of the Amazon EC2 instances of your application

Type: `number`

Default: `15`

### <a name="input_autoscale_min"></a> [autoscale\_min](#input\_autoscale\_min)

Description: Minumum instances to launch

Type: `number`

Default: `1`

### <a name="input_autoscale_max"></a> [autoscale\_max](#input\_autoscale\_max)

Description: Maximum instances to launch

Type: `number`

Default: `1`

### <a name="input_env_vars"></a> [env\_vars](#input\_env\_vars)

Description: Map of custom ENV variables to be provided to the application running on Elastic Beanstalk, e.g. env\_vars = { DB\_USER = 'admin' DB\_PASS = 'xxxxxx' }

Type: `map(string)`

Default: `{}`

### <a name="input_dns_zone_id"></a> [dns\_zone\_id](#input\_dns\_zone\_id)

Description: Route53 parent zone ID. The module will create sub-domain DNS record in the parent zone for the EB environment

Type: `string`

Default: `""`

### <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name)

Description: n/a

Type: `string`

Default: `""`

### <a name="input_dns_subdomain"></a> [dns\_subdomain](#input\_dns\_subdomain)

Description: The subdomain to create on Route53 for the EB environment. For the subdomain to be created, the `dns_zone_id` variable must be set as well

Type: `string`

Default: `""`

### <a name="input_deployment_version"></a> [deployment\_version](#input\_deployment\_version)

Description: n/a

Type: `string`

Default: `"initial"`

### <a name="input_deployment_bucket"></a> [deployment\_bucket](#input\_deployment\_bucket)

Description: n/a

Type: `string`

Default: `null`

### <a name="input_deployment_file_path"></a> [deployment\_file\_path](#input\_deployment\_file\_path)

Description: n/a

Type: `string`

Default: `"Dockerrun.aws.json"`

### <a name="input_deployment_definition"></a> [deployment\_definition](#input\_deployment\_definition)

Description: n/a

Type: `string`

Default: `null`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: A map of additional tags to apply to all VPC resources

Type: `map(string)`

Default: `{}`

### <a name="input_subject_alternative_names"></a> [subject\_alternative\_names](#input\_subject\_alternative\_names)

Description: n/a

Type: `list(string)`

Default: `[]`

### <a name="input_validation_allow_overwrite_records"></a> [validation\_allow\_overwrite\_records](#input\_validation\_allow\_overwrite\_records)

Description: n/a

Type: `bool`

Default: `true`

<!-- TFDOCS_INPUTS_END -->

<!-- TFDOCS_OUTPUTS_START -->
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_elastic_beanstalk_application_name"></a> [elastic\_beanstalk\_application\_name](#output\_elastic\_beanstalk\_application\_name) | Elastic Beanstalk Application name |
| <a name="output_elastic_beanstalk_environment_all_settings"></a> [elastic\_beanstalk\_environment\_all\_settings](#output\_elastic\_beanstalk\_environment\_all\_settings) | List of all option settings configured in the environment. These are a combination of default settings and their overrides from setting in the configuration |
| <a name="output_elastic_beanstalk_environment_application"></a> [elastic\_beanstalk\_environment\_application](#output\_elastic\_beanstalk\_environment\_application) | The Elastic Beanstalk Application specified for this environment |
| <a name="output_elastic_beanstalk_environment_autoscaling_groups"></a> [elastic\_beanstalk\_environment\_autoscaling\_groups](#output\_elastic\_beanstalk\_environment\_autoscaling\_groups) | The autoscaling groups used by this environment |
| <a name="output_elastic_beanstalk_environment_ec2_instance_profile_role_name"></a> [elastic\_beanstalk\_environment\_ec2\_instance\_profile\_role\_name](#output\_elastic\_beanstalk\_environment\_ec2\_instance\_profile\_role\_name) | Instance IAM role name |
| <a name="output_elastic_beanstalk_environment_elb_zone_id"></a> [elastic\_beanstalk\_environment\_elb\_zone\_id](#output\_elastic\_beanstalk\_environment\_elb\_zone\_id) | ELB zone id |
| <a name="output_elastic_beanstalk_environment_endpoint"></a> [elastic\_beanstalk\_environment\_endpoint](#output\_elastic\_beanstalk\_environment\_endpoint) | Fully qualified DNS name for the environment |
| <a name="output_elastic_beanstalk_environment_hostname"></a> [elastic\_beanstalk\_environment\_hostname](#output\_elastic\_beanstalk\_environment\_hostname) | DNS hostname |
| <a name="output_elastic_beanstalk_environment_id"></a> [elastic\_beanstalk\_environment\_id](#output\_elastic\_beanstalk\_environment\_id) | ID of the Elastic Beanstalk environment |
| <a name="output_elastic_beanstalk_environment_instances"></a> [elastic\_beanstalk\_environment\_instances](#output\_elastic\_beanstalk\_environment\_instances) | Instances used by this environment |
| <a name="output_elastic_beanstalk_environment_launch_configurations"></a> [elastic\_beanstalk\_environment\_launch\_configurations](#output\_elastic\_beanstalk\_environment\_launch\_configurations) | Launch configurations in use by this environment |
| <a name="output_elastic_beanstalk_environment_load_balancers"></a> [elastic\_beanstalk\_environment\_load\_balancers](#output\_elastic\_beanstalk\_environment\_load\_balancers) | Elastic Load Balancers in use by this environment |
| <a name="output_elastic_beanstalk_environment_name"></a> [elastic\_beanstalk\_environment\_name](#output\_elastic\_beanstalk\_environment\_name) | Name |
| <a name="output_elastic_beanstalk_environment_queues"></a> [elastic\_beanstalk\_environment\_queues](#output\_elastic\_beanstalk\_environment\_queues) | SQS queues in use by this environment |
| <a name="output_elastic_beanstalk_environment_security_group_arn"></a> [elastic\_beanstalk\_environment\_security\_group\_arn](#output\_elastic\_beanstalk\_environment\_security\_group\_arn) | Elastic Beanstalk environment Security Group ARN |
| <a name="output_elastic_beanstalk_environment_security_group_id"></a> [elastic\_beanstalk\_environment\_security\_group\_id](#output\_elastic\_beanstalk\_environment\_security\_group\_id) | Elastic Beanstalk environment Security Group ID |
| <a name="output_elastic_beanstalk_environment_security_group_name"></a> [elastic\_beanstalk\_environment\_security\_group\_name](#output\_elastic\_beanstalk\_environment\_security\_group\_name) | Elastic Beanstalk environment Security Group name |
| <a name="output_elastic_beanstalk_environment_setting"></a> [elastic\_beanstalk\_environment\_setting](#output\_elastic\_beanstalk\_environment\_setting) | Settings specifically set for this environment |
| <a name="output_elastic_beanstalk_environment_tier"></a> [elastic\_beanstalk\_environment\_tier](#output\_elastic\_beanstalk\_environment\_tier) | The environment tier |
| <a name="output_elastic_beanstalk_environment_triggers"></a> [elastic\_beanstalk\_environment\_triggers](#output\_elastic\_beanstalk\_environment\_triggers) | Autoscaling triggers in use by this environment |

<!-- TFDOCS_OUTPUTS_END -->

## License

**[MIT License](LICENSE)**

Copyright (c) 2022 **[Flaconi GmbH](https://github.com/flaconi)**
