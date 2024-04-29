provider "aws" {
  region = "ap-southeast-1"
}
module "vpc" {
    source  = "../../network/vpc"
    name    = "Test"
}

# Single nat
module "nat" {
    source = "../../network/fck_nat"
    vpc_id = module.vpc.vpc_id
    nat_subnet_id = module.vpc.public_subnet_ids[0]
    subnet_ids = module.vpc.private_subnet_ids
    
    depends_on = [module.vpc]
}

module "rds_instance" {
    source = "../../storage/rds_instance"
    
    db_identifier = "rds-isntance"
    db_name = "mydatabase"
    engine = "mysql"
    engine_version = "8.0"
    subnet_ids = module.vpc.private_subnet_ids
    vpc_id = module.vpc.vpc_id
}