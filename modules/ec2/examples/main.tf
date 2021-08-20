#EC2 module
##########
variable "role_arn" {}

provider "aws" {
  assume_role {
    role_arn = var.role_arn
  }
  alias = "sandbox"
}

module "my_ec2" {
  source                 = "../"
  region                 = "eu-west-2"
  instance_count         = 1
  name                   = "test"
  instance_type          = "t2.micro"
  key_name               = "dev-test"
  monitoring             = false
  vpc_security_group_ids = []
  subnet_id              = ""
  termination_protection = false //set this to true when deploying in actual invironment
  iam_instance_profile   = null  //replace with an actual IAM profile name

  providers = {
    aws = aws.sandbox
  }
}
