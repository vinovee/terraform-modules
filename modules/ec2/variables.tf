
variable "region" {
  default = "eu-west-2"
}

variable "env" {
  description = "VPC Environment"
  default     = "sandbox"
}

variable "name" {
  description = "Tag name for instance to be used on all resources as prefix"
  default     = "ec2"
}

variable "ami-identifier" {
  description = "AMI identifier. This is part of AMI name. Valid values are 'ami-22b9a343' etc."
  default     = "amzn2-ami-hvm"
}


variable "ami_id" {
  description = "default ami id. This is part of AMI id."
  default     = ""
}

variable "create_instance" {
  description = "Do you want to create Instance? true or false"
  default     = true
}

variable "instance_count" {
  description = "Number of instances to launch"
  default     = 1
}

variable "instance_type" {
  description = "Set of instance types associated with the EKS Node Group. Defaults to ['t2.micro']."
  default     = "t2.micro"
}

variable "user_data" {
  description = "The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead."
  default     = null
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
}

variable "key_name" {
  description = "The key name to use for the instance"
}

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  default     = false
}

variable "iam_instance_profile" {
  description = "The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile."
  default     = null
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  default     = []
}

variable "termination_protection" {
  description = "If true, enables EC2 Instance Termination Protection"
  default     = false
}

variable "placement_group" {
  description = "The Placement Group to start the instance in"
  default     = null
}

variable "tenancy" {
  description = "The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host."
  default     = "default"
}

variable "delete_on_termination" {
  description = "(Optional) Whether the volume should be destroyed on instance termination."
  default     = true
}

variable "volume_type" {
  description = "(Optional) The type of ROOT volume. Can be 'standard', 'gp2', 'o1', 'sc1', or 'st1'."
  default     = "gp2"
}

variable "volume_size" {
  description = "(Optional) The size of the volume in gibibytes (GiB)."
  default     = null
}

variable "encrypted" {
  description = "(Optional) Enable volume encryption."
  default     = false
}

variable "owners" {
  description = "(Required) List of AMI owners to limit search. At least 1 value must be specified. Valid values: an AWS account ID, self (the current account), or an AWS owner alias (e.g. amazon, aws-marketplace, microsoft)"
  default     = ["amazon"]
}

variable "required-tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the devices created by the instance at launch time"
  default = {
    CreatedBy = "Terraform"
  }
}
