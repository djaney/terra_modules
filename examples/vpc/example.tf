provider "aws" {
  region = "ap-southeast-1"
}
module "vpc" {
    source  = "../../src/network/vpc"
    name    = "Test"
}
