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

output "vpc_id" {
  value = concat(aws_vpc.vpc.*.id, [""])[0]
}

output "vpc_cidr" {
  value = concat(aws_vpc.vpc.*.cidr_block, [""])[0]
}

output "public_subnets" {
  value = aws_subnet.public_subnets.*.id
}

output "web_subnets" {
  value = aws_subnet.web_subnets.*.id
}

output "app_subnets" {
  value = aws_subnet.app_subnets.*.id
}

output "db_subnets" {
  value = aws_subnet.db_subnets.*.id
}

output "public_route" {
  value = aws_route_table.public_route.*.id
}

output "web_route" {
  value = aws_route_table.web_route.*.id
}

output "app_route" {
  value = aws_route_table.app_route.*.id
}

output "db_route" {
  value = aws_route_table.db_route.*.id
}

output "igw" {
  value = concat(aws_internet_gateway.igw.*.id, [""])[0]
}

output "ngw" {
  value = aws_nat_gateway.ngw.*.id
}

output "public_nacl" {
  value = concat(aws_network_acl.public_nacl.*.id, [""])[0]
}

output "web_nacl" {
  value = concat(aws_network_acl.web_nacl.*.id, [""])[0]
}

output "app_nacl" {
  value = concat(aws_network_acl.app_nacl.*.id, [""])[0]
}

output "db_nacl" {
  value = concat(aws_network_acl.db_nacl.*.id, [""])[0]
}
