provider "aws" {
  region = "ap-southeast-1"
}
module "vpc" {
    source  = "../../src/network/vpc"
    name    = "Test"
}


# Multi nat
module "nat" {
    source = "../../src/network/fck_nat"
    count = length(module.vpc.public_subnet_ids)
    vpc_id = module.vpc.vpc_id
    nat_subnet_id = module.vpc.public_subnet_ids[count.index]
    subnet_ids = [module.vpc.private_subnet_ids[count.index]]
    
    depends_on = [module.vpc]
}

