provider "aws" {
  region = "ap-southeast-1"
}
module "vpc" {
    source  = "../../src/network/vpc"
    name    = "Test"
}

# Single nat
module "nat" {
    source = "../../src/network/fck_nat"
    vpc_id = module.vpc.vpc_id
    nat_subnet_id = module.vpc.public_subnet_ids[0]
    subnet_ids = module.vpc.private_subnet_ids
    
    depends_on = [module.vpc]
}
