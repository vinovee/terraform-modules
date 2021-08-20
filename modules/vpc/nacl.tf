######################
#Network ACLs - OUTBOUND
######################
resource "aws_network_acl_rule" "public_outbound" {
  count          = var.create_vpc && length(local.public_subnets) > 0 ? 1 : 0
  network_acl_id = aws_network_acl.public_nacl[count.index].id
  protocol       = "-1"
  rule_action    = "allow"
  rule_number    = 110
  cidr_block     = "0.0.0.0/0"
  egress         = true
}

resource "aws_network_acl_rule" "web_outbound" {
  count          = var.create_vpc && length(local.web_subnets) > 0 ? 1 : 0
  network_acl_id = aws_network_acl.web_nacl[count.index].id
  protocol       = "-1"
  rule_action    = "allow"
  rule_number    = 110
  cidr_block     = "0.0.0.0/0"
  egress         = true
}

resource "aws_network_acl_rule" "app_outbound" {
  count          = var.create_vpc && length(local.app_subnets) > 0 ? 1 : 0
  network_acl_id = aws_network_acl.app_nacl[count.index].id
  protocol       = "-1"
  rule_action    = "allow"
  rule_number    = 110
  cidr_block     = "0.0.0.0/0"
  egress         = true
}

resource "aws_network_acl_rule" "db_outbound" {
  count          = var.create_vpc && length(local.db_subnets) > 0 ? 1 : 0
  network_acl_id = aws_network_acl.db_nacl[count.index].id
  protocol       = "-1"
  rule_action    = "allow"
  rule_number    = 110
  cidr_block     = "0.0.0.0/0"
  egress         = true
}

######################
#Network ACLs - INBOUND - public_subnets
######################
resource "aws_network_acl_rule" "public_nacl_internal" {
  count          = var.create_vpc && length(local.public_subnets) > 0 ? 1 : 0
  network_acl_id = aws_network_acl.public_nacl[count.index].id
  protocol       = "-1"
  rule_action    = "allow"
  rule_number    = 110
  cidr_block     = var.vpc_cidr_block
}

resource "aws_network_acl_rule" "public_nacl_port80" {
  count          = var.create_vpc && length(local.public_subnets) > 0 ? 1 : 0
  network_acl_id = aws_network_acl.public_nacl[count.index].id
  protocol       = "tcp"
  rule_action    = "allow"
  rule_number    = 111
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "public_nacl_port443" {
  count          = var.create_vpc && length(local.public_subnets) > 0 ? 1 : 0
  network_acl_id = aws_network_acl.public_nacl[count.index].id
  protocol       = "tcp"
  rule_action    = "allow"
  rule_number    = 112
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "public_nacl_ephemeral" {
  count          = var.create_vpc && length(local.public_subnets) > 0 ? 1 : 0
  network_acl_id = aws_network_acl.public_nacl[count.index].id
  protocol       = "tcp"
  rule_action    = "allow"
  rule_number    = 113
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "public_nacl_port22" {
  count          = var.create_vpc && length(local.public_subnets) > 0 ? 1 : 0
  network_acl_id = aws_network_acl.public_nacl[count.index].id
  protocol       = "tcp"
  rule_action    = "allow"
  rule_number    = 114
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22
}

######################
#Network ACLs - INBOUND - web_subnets
######################
resource "aws_network_acl_rule" "web_nacl_internal" {
  count          = var.create_vpc && length(local.web_subnets) > 0 ? 1 : 0
  network_acl_id = aws_network_acl.web_nacl[count.index].id
  protocol       = "-1"
  rule_action    = "allow"
  rule_number    = 110
  cidr_block     = var.vpc_cidr_block
}

resource "aws_network_acl_rule" "web_nacl_port80" {
  count          = var.create_vpc && length(local.web_subnets) > 0 ? 1 : 0
  network_acl_id = aws_network_acl.web_nacl[count.index].id
  protocol       = "tcp"
  rule_action    = "allow"
  rule_number    = 111
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "web_nacl_port443" {
  count          = var.create_vpc && length(local.web_subnets) > 0 ? 1 : 0
  network_acl_id = aws_network_acl.web_nacl[count.index].id
  protocol       = "tcp"
  rule_action    = "allow"
  rule_number    = 112
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "web_nacl_ephemeral" {
  count          = var.create_vpc && length(local.web_subnets) > 0 ? 1 : 0
  network_acl_id = aws_network_acl.web_nacl[count.index].id
  protocol       = "tcp"
  rule_action    = "allow"
  rule_number    = 113
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

######################
#Network ACLs - INBOUND - app_subnets
######################
resource "aws_network_acl_rule" "app_nacl_internal" {
  count          = var.create_vpc && length(local.app_subnets) > 0 ? 1 : 0
  network_acl_id = aws_network_acl.app_nacl[count.index].id
  protocol       = "-1"
  rule_action    = "allow"
  rule_number    = 110
  cidr_block     = var.vpc_cidr_block
}

resource "aws_network_acl_rule" "app_nacl_port80" {
  count          = var.create_vpc && length(local.app_subnets) > 0 ? 1 : 0
  network_acl_id = aws_network_acl.app_nacl[count.index].id
  protocol       = "tcp"
  rule_action    = "allow"
  rule_number    = 111
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "app_nacl_port443" {
  count          = var.create_vpc && length(local.app_subnets) > 0 ? 1 : 0
  network_acl_id = aws_network_acl.app_nacl[count.index].id
  protocol       = "tcp"
  rule_action    = "allow"
  rule_number    = 112
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "app_nacl_ephemeral" {
  count          = var.create_vpc && length(local.app_subnets) > 0 ? 1 : 0
  network_acl_id = aws_network_acl.app_nacl[count.index].id
  protocol       = "tcp"
  rule_action    = "allow"
  rule_number    = 113
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

######################
#Network ACLs - INBOUND - db_subnets
######################
resource "aws_network_acl_rule" "db_nacl_internal" {
  count          = var.create_vpc && length(local.db_subnets) > 0 ? 1 : 0
  network_acl_id = aws_network_acl.db_nacl[count.index].id
  protocol       = "-1"
  rule_action    = "allow"
  rule_number    = 110
  cidr_block     = var.vpc_cidr_block
}

resource "aws_network_acl_rule" "db_nacl_port80" {
  count          = var.create_vpc && length(local.db_subnets) > 0 ? 1 : 0
  network_acl_id = aws_network_acl.db_nacl[count.index].id
  protocol       = "tcp"
  rule_action    = "allow"
  rule_number    = 111
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "db_nacl_port443" {
  count          = var.create_vpc && length(local.db_subnets) > 0 ? 1 : 0
  network_acl_id = aws_network_acl.db_nacl[count.index].id
  protocol       = "tcp"
  rule_action    = "allow"
  rule_number    = 112
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "db_nacl_ephemeral" {
  count          = var.create_vpc && length(local.db_subnets) > 0 ? 1 : 0
  network_acl_id = aws_network_acl.db_nacl[count.index].id
  protocol       = "tcp"
  rule_action    = "allow"
  rule_number    = 113
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}
