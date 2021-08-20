# All your variable definitions are in this file

# Always add a description to the variable (self documenting code)
# if the variable is not a string you will need to set type.
# See: https://www.terraform.io/docs/configuration/variables.html

# To add these tages into already defined tags (like a name) you can use following
# interpolation syntax
#
# tags = "${merge(var.tags, map(
#    "Name", var.name
#  ))}"
#

variable "region" {
  description = "AWS region where all the components in this module will be created"
  default     = "eu-west-2"
}

variable "env" {
  description = "VPC Environment"
  default     = "sandbox"
}


variable "create_vpc" {
  description = "Value to decide create VPC or not"
  default     = true
}

#variable "aws_availibilty_zones" {
# type    = list(string)
#default = ["eu-west-2c", "eu-west-2b", "eu-west-2a"]
#}


variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  default     = []
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames?"
  default     = true
}

variable "enable_dns_support" {
  description = "Enable DNS support?"
  default     = true
}

variable "map_public_ip_on_launch" {
  description = "(Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is false."
  default     = true
}

//variable "public_cidrs" {
//  description = "List of public subnets inside the VPC"
//  type    = list(string)
//  default = []
//}
//
//variable "web_cidrs" {
//  description = "List of web subnets inside the VPC"
//  type    = list(string)
//  default = []
//}
//
//variable "app_cidrs" {
//  description = "List of application subnets inside the VPC"
//  type    = list(string)
//  default = []
//}
//
//variable "db_cidrs" {
//  description = "List of public subnets inside the VPC"
//  type    = list(string)
//  default = []
//}


variable "required-tags" {
  type = map(string)

  default = {
    AutomatedBy = "Terraform"
    Owner       = ""
  }
}

variable "create_transit_gw" {
  description = "Do you want to create transit gateway?"
  default     = false
}

variable "auto_accept_shared_attachments" {
  description = "(optional) Sepecify enable to accept the shared vpc attachment"
  default     = "disable"

}

variable "vpc_name" {
  description = "name added to represent specific service in addition to environment name"
  default     = " "
}
