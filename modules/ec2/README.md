# Terraform AWS EC2

## Description
Terraform module which creates EC2 instance(s) on AWS.

Note: You can specify required ami with variable ami_id. If ami_id variable is not specified, ec2 instace gets created with latest Amazon Linux 2 AMI

## Prerequisites
Any Prerequisites required for the module.

Complete - Complete ec2 with most of supported features enabled

subnet_ids
vpc_security_group_ids
key_pair



## Input variables

Below are list of variables that should be available in terraform.tfvars file

| **Name**	| **type**	| **Description**	|
|-----------|-----------|-----------------|
| **source** | path | path name from where called apigateway module |
| **region** | string | region into which to deploy the API gateway |
| **ami-identifier** | string | ID of AMI to use for the instance |
| **instance_count** | string | Number of instances to launch |
| **instance_type** | string | The type of instance to start|
| **key_name** | string | The key name to use for the instance |
| **monitoring** | bool | If true, the launched EC2 instance will have detailed monitoring enabled |
| **vpc_security_group_ids** | string | A list of security group IDs to associate with |
| **subnet_id** | string | The VPC Subnet ID to launch in |
| **termination_protection** | bool | If true, enables EC2 Instance Termination Protection |
| **tenancy** | string | tenancy name |
| **encrypted** | bool | ebs encrypted or not |
| **iam_instance_profile** | string | The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile. |
| **owners** | string | List of AMI owners Valid values: an AWS account ID, amazon, aws-marketplace, microsoft|


## Output variables

A list of output variables 

| **Name**	| **Description**	|
|-----------|-----------|
| **instance_id** | List of IDs of instances |
| **instance_arn** |  List of ARNs of instances | 
| **availability_zone** |  List of availability zones of instances | 
| **public_dns** |  List of public DNS names assigned to the instances. This is only available if you've enabled DNS hostnames for your VPC | 