provider "aws" {
  region = "ap-southeast-1"
}
module "vpc" {
    source  = "../../network/vpc"
    name    = "Test"
}
