# output definitions are in this file.

# This is what your module will make available to the module that will call your
# module.
#
# Syntax:
# output "my_var" {
#   value="some_value"
# }

# This can be used by the parent module like this:
#
# property = "${module.my-module.my_var}"
#
# This will result in:
#
# propety = "some_value"


output "instance_id" {
  description = "List of IDs of instances"
  value       = concat(aws_instance.ec2-instance.*.id, [""])[0]
}

output "instance_arn" {
  description = "List of ARNs of instances"
  value       = concat(aws_instance.ec2-instance.*.arn, [""])[0]
}

output "availability_zone" {
  description = "List of availability zones of instances"
  value       = concat(aws_instance.ec2-instance.*.availability_zone, [""])[0]
}

output "public_dns" {
  description = "List of public DNS names assigned to the instances. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
  value       = concat(aws_instance.ec2-instance.*.public_dns, [""])[0]
}