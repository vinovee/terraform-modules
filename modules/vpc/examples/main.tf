module "vpc" {
  source         = "../"
  region         = "eu-west-2"
  env            = "sandbox"
  vpc_cidr_block = "10.5.0.0/18"
}
