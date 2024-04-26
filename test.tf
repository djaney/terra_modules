module "vpc" {
    source = "./network/vpc"
}
module "fck_nat" {
    source = "./network/fck_nat"
    vpc = module.vpc.vpc
    subnets = module.vpc.private_subnets
}
module "rds_instance" {
    source = "./storage/rds_instance"
    
    db_identifier = "rds_isntance"
    db_name = "mydatabase"
    engine = "mysql"
    engine_version = "8.0"
    subnet_ids = module.vpc.private_subnets[*].id
    vpc = module.vpc.vpc
}