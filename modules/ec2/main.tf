#Service module for EC2 instance creation

#Provider
provider "aws" {}

data "aws_ami" "latest_ami" {
  owners      = var.owners
  most_recent = true

  filter {
    name   = "name"
    values = ["${var.ami-identifier}-*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_instance" "ec2-instance" {
  count                   = var.create_instance ? var.instance_count : 0
  ami                     = length("${var.ami_id}") > 0 ? var.ami_id : data.aws_ami.latest_ami.id
  instance_type           = var.instance_type
  user_data               = var.user_data
  subnet_id               = var.subnet_id
  key_name                = var.key_name
  monitoring              = var.monitoring
  vpc_security_group_ids  = var.vpc_security_group_ids
  iam_instance_profile    = var.iam_instance_profile
  disable_api_termination = var.termination_protection
  placement_group         = var.placement_group
  tenancy                 = var.tenancy


  root_block_device {
    volume_type           = var.volume_type
    volume_size           = var.volume_size
    delete_on_termination = var.delete_on_termination
    encrypted             = var.encrypted
  }


  tags = merge(
    var.required-tags,
    {
      "Name"        = "ec2-${var.env}-${var.name}-${count.index + 1}"
      "Environment" = var.env
    }
  )

  volume_tags = merge(
    var.required-tags,
    {
      "Name"        = "ebs-${var.env}-${var.name}-root"
      "Environment" = var.env
    }
  )

}
