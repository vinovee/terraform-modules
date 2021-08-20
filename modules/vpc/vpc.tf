# This will be the main file of the terraform module. if your module does not
# contain a lot of resources, this file can be used to specify them, otherwise
# only following entries can be in here:
# - provider
# - locals

# Basic provider. If you require multiple providers you will need to define aliases
# See: https://www.terraform.io/docs/modules/usage.html#providers-within-modules
#AWS Provider
provider "aws" {}

#Below locals block will calculate /24 subnets given that cidr block is /20. you need to change according to the requirement.
#if cidr block is /16 then it will devide subnets in to /20 subnets
#if cidr block is /18 then it will devide subnets in to /222 subnets
locals {
  public_subnets = [cidrsubnet(var.vpc_cidr_block, 4, 0), cidrsubnet(var.vpc_cidr_block, 4, 1), cidrsubnet(var.vpc_cidr_block, 4, 2)]
  web_subnets    = [cidrsubnet(var.vpc_cidr_block, 4, 3), cidrsubnet(var.vpc_cidr_block, 4, 4), cidrsubnet(var.vpc_cidr_block, 4, 5)]
  #web_subnets = []
  app_subnets = [cidrsubnet(var.vpc_cidr_block, 4, 6), cidrsubnet(var.vpc_cidr_block, 4, 7), cidrsubnet(var.vpc_cidr_block, 4, 8)]
  db_subnets  = [cidrsubnet(var.vpc_cidr_block, 4, 9), cidrsubnet(var.vpc_cidr_block, 4, 10), cidrsubnet(var.vpc_cidr_block, 4, 11)]
}

# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

# Create VPC
resource "aws_vpc" "vpc" {
  count                = var.create_vpc ? 1 : 0
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags = merge(
    var.required-tags,
    {
      "Name"        = var.vpc_name == " " ? "${var.env}-${var.region}-vpc-01" : "${var.env}-${var.region}-vpc-${var.vpc_name}-01"
      "Environment" = var.env
    },
  )
}

# Create Internet gateway
resource "aws_internet_gateway" "igw" {
  count  = var.create_vpc ? 1 : 0
  vpc_id = aws_vpc.vpc[0].id

  tags = merge(
    var.required-tags,
    {
      "Name"        = var.vpc_name == " " ? "${var.env}-${var.region}-igw-01" : "${var.env}-${var.vpc_name}-igw-01"
      "Environment" = var.env
    },
  )

}

#Create NAT Gateway
resource "aws_eip" "nat" {
  count = var.create_vpc && length(local.public_subnets) > 0 ? length(local.public_subnets) : 0
  vpc   = true
  tags = merge(
    var.required-tags,
    {
      "Name"        = var.vpc_name == " " ? "${var.env}-${var.region}-nat-eip-${count.index + 1}" : "${var.env}-${var.vpc_name}-nat-eip-${count.index + 1}"
      "Environment" = var.env
    },
  )

}
resource "aws_nat_gateway" "ngw" {
  count         = var.create_vpc && length(local.public_subnets) > 0 ? length(local.public_subnets) : 0
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index].id
  depends_on    = [aws_internet_gateway.igw, aws_subnet.public_subnets]

  tags = merge(
    var.required-tags,
    {
      "Name"        = var.vpc_name == " " ? "${var.env}-${var.region}-ngw-${count.index + 1}" : "${var.env}-${var.region}-${var.vpc_name}-ngw-${count.index + 1}"
      "Environment" = var.env
    },
  )
}

#Create Public subnets
resource "aws_subnet" "public_subnets" {
  count                   = var.create_vpc && length(local.public_subnets) > 0 ? length(local.public_subnets) : 0
  vpc_id                  = aws_vpc.vpc[0].id
  cidr_block              = local.public_subnets[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = merge(
    var.required-tags,
    {
      "Name"        = var.vpc_name == " " ? "${var.env}-${var.region}-public-subnet-${count.index + 1}" : "${var.env}-${var.region}-${var.vpc_name}-public-subnet-${count.index + 1}"
      "Environment" = var.env
    },
  )
}

#Create Private subnet - web
resource "aws_subnet" "web_subnets" {
  count             = var.create_vpc && length(local.web_subnets) > 0 ? length(local.web_subnets) : 0
  vpc_id            = aws_vpc.vpc[0].id
  cidr_block        = local.web_subnets[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = merge(
    var.required-tags,
    {
      "Name"        = var.vpc_name == " " ? "${var.env}-${var.region}-web-subnet-${count.index + 1}" : "${var.env}-${var.region}-${var.vpc_name}-web-subnet-${count.index + 1}"
      "Environment" = var.env
    },
  )
}

#Create Private subnet - application
resource "aws_subnet" "app_subnets" {
  count             = var.create_vpc && length(local.app_subnets) > 0 ? length(local.app_subnets) : 0
  vpc_id            = aws_vpc.vpc[0].id
  cidr_block        = local.app_subnets[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = merge(
    var.required-tags,
    {
      "Name"        = var.vpc_name == " " ? "${var.env}-${var.region}-app-subnet-${count.index + 1}" : "${var.env}-${var.region}-${var.vpc_name}-app-subnet-${count.index + 1}"
      "Environment" = var.env
    },
  )
}

#Create Private subnet - database
resource "aws_subnet" "db_subnets" {
  count             = var.create_vpc && length(local.db_subnets) > 0 ? length(local.db_subnets) : 0
  vpc_id            = aws_vpc.vpc[0].id
  cidr_block        = local.db_subnets[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = merge(
    var.required-tags,
    {
      "Name"        = var.vpc_name == " " ? "${var.env}-${var.region}-db-subnet-${count.index + 1}" : "${var.env}-${var.region}-${var.vpc_name}-db-subnet-${count.index + 1}"
      "Environment" = var.env
    },
  )
}

#Public routes
# Create public route_table
resource "aws_route_table" "public_route" {
  count  = var.create_vpc && length(local.public_subnets) > 0 ? length(local.public_subnets) : 0
  vpc_id = aws_vpc.vpc[0].id

  tags = merge(
    var.required-tags,
    {
      "Name"        = var.vpc_name == " " ? "${var.env}-${var.region}-public-rtb-${count.index + 1}" : "${var.env}-${var.region}-${var.vpc_name}-public-rtb-${count.index + 1}"
      "Environment" = var.env
    },
  )
}

# Public Subnet route table Association
resource "aws_route_table_association" "pub_sub_assoc" {
  count          = var.create_vpc && length(local.public_subnets) > 0 ? length(local.public_subnets) : 0
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route[count.index].id
}
resource "aws_route" "public_igw" {
  count                  = var.create_vpc && length(local.public_subnets) > 0 ? length(local.public_subnets) : 0
  route_table_id         = aws_route_table.public_route[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw[0].id
}


# Private routes
# Create private route_table - web
resource "aws_route_table" "web_route" {
  count  = var.create_vpc && length(local.web_subnets) > 0 ? length(local.web_subnets) : 0
  vpc_id = aws_vpc.vpc[0].id

  tags = merge(
    var.required-tags,
    {
      "Name"        = var.vpc_name == " " ? "${var.env}-${var.region}-web-rtb-${count.index + 1}" : "${var.env}-${var.region}-${var.vpc_name}-web-rtb-${count.index + 1}"
      "Environment" = var.env
    },
  )
}

#web Subnet route table Association
resource "aws_route_table_association" "priv_web_assoc" {
  count          = var.create_vpc && length(local.web_subnets) > 0 ? length(local.web_subnets) : 0
  subnet_id      = aws_subnet.web_subnets[count.index].id
  route_table_id = aws_route_table.web_route[count.index].id
}

resource "aws_route" "web_nat" {
  count                  = var.create_vpc && length(local.web_subnets) > 0 ? length(local.web_subnets) : 0
  route_table_id         = aws_route_table.web_route[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw[count.index].id
}

# Create private route_table - application
resource "aws_route_table" "app_route" {
  count  = var.create_vpc && length(local.app_subnets) > 0 ? length(local.app_subnets) : 0
  vpc_id = aws_vpc.vpc[0].id

  tags = merge(
    var.required-tags,
    {
      "Name"        = var.vpc_name == " " ? "${var.env}-${var.region}-app-rtb-${count.index + 1}" : "${var.env}-${var.region}-${var.vpc_name}-app-rtb-${count.index + 1}"
      "Environment" = var.env
    },
  )
}

#application Subnet route table Association
resource "aws_route_table_association" "priv_app_assoc" {
  count          = var.create_vpc && length(local.app_subnets) > 0 ? length(local.app_subnets) : 0
  subnet_id      = aws_subnet.app_subnets[count.index].id
  route_table_id = aws_route_table.app_route[count.index].id
}
resource "aws_route" "app_nat" {
  count                  = var.create_vpc && length(local.app_subnets) > 0 ? length(local.app_subnets) : 0
  route_table_id         = aws_route_table.app_route[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw[count.index].id
}

# Create private route_table - database
resource "aws_route_table" "db_route" {
  count  = var.create_vpc && length(local.db_subnets) > 0 ? length(local.db_subnets) : 0
  vpc_id = aws_vpc.vpc[0].id

  tags = merge(
    var.required-tags,
    {
      "Name"        = var.vpc_name == " " ? "${var.env}-${var.region}-db-rtb-${count.index + 1}" : "${var.env}-${var.region}-${var.vpc_name}-db-rtb-${count.index + 1}"
      "Environment" = var.env
    },
  )
}

#database Subnet route table Association
resource "aws_route_table_association" "priv_db_assoc" {
  count          = var.create_vpc && length(local.db_subnets) > 0 ? length(local.db_subnets) : 0
  subnet_id      = aws_subnet.db_subnets[count.index].id
  route_table_id = aws_route_table.db_route[count.index].id
}

resource "aws_route" "db_nat" {
  count                  = var.create_vpc && length(local.db_subnets) > 0 ? length(local.db_subnets) : 0
  route_table_id         = aws_route_table.db_route[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw[count.index].id
}

#Network ACLs
# Public
resource "aws_network_acl" "public_nacl" {
  count      = var.create_vpc && length(local.public_subnets) > 0 ? 1 : 0
  vpc_id     = aws_vpc.vpc[0].id
  subnet_ids = aws_subnet.public_subnets.*.id
  tags = merge(
    var.required-tags,
    {
      "Name"        = var.vpc_name == " " ? "${var.env}-${var.region}-public-nacl" : "${var.env}-${var.region}-${var.vpc_name}-public-nacl"
      "Environment" = var.env
    },
  )

}

#Web
resource "aws_network_acl" "web_nacl" {
  count      = var.create_vpc && length(local.web_subnets) > 0 ? 1 : 0
  vpc_id     = aws_vpc.vpc[0].id
  subnet_ids = aws_subnet.web_subnets.*.id
  tags = merge(
    var.required-tags,
    {
      "Name"        = var.vpc_name == " " ? "${var.env}-${var.region}-web-nacl" : "${var.env}-${var.region}-${var.vpc_name}-web-nacl"
      "Environment" = var.env
    },
  )

}

#Application
resource "aws_network_acl" "app_nacl" {
  count      = var.create_vpc && length(local.app_subnets) > 0 ? 1 : 0
  vpc_id     = aws_vpc.vpc[0].id
  subnet_ids = aws_subnet.app_subnets.*.id
  tags = merge(
    var.required-tags,
    {
      "Name"        = var.vpc_name == " " ? "${var.env}-${var.region}-app-nacl" : "${var.env}-${var.region}-${var.vpc_name}-app-nacl"
      "Environment" = var.env
    },
  )

}

#Database
resource "aws_network_acl" "db_nacl" {
  count      = var.create_vpc && length(local.db_subnets) > 0 ? 1 : 0
  vpc_id     = aws_vpc.vpc[0].id
  subnet_ids = aws_subnet.db_subnets.*.id
  tags = merge(
    var.required-tags,
    {
      "Name"        = var.vpc_name == " " ? "${var.env}-${var.region}-db-nacl" : "${var.env}-${var.region}-${var.vpc_name}-db-nacl"
      "Environment" = var.env
    },
  )

}

#Transit gateway
resource "aws_ec2_transit_gateway" "tgw" {
  count                          = var.create_vpc && var.create_transit_gw && var.env == "shared" ? 1 : 0
  auto_accept_shared_attachments = var.auto_accept_shared_attachments

  tags = merge(
    var.required-tags,
    {
      "Name"        = var.vpc_name == " " ? "${var.env}-${var.region}-tgw" : "${var.env}-${var.region}-${var.vpc_name}-tgw"
      "Environment" = var.env
    },
  )
}
