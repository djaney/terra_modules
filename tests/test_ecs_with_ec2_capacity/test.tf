provider "aws" {
  region = "ap-southeast-1"
}
module "vpc" {
    source  = "../../network/vpc"
    name    = "Test"
}

module "ecs_cluster" {
  source = "../../ecs/ecs_cluster"
  name = "test"
  depends_on = [module.vpc]
}


module "ecs_capacity_provider" {
  source = "../../ecs/ecs_capacity_ec2"
  vpc_id = module.vpc.vpc_id
  cluster_name = module.ecs_cluster.cluster_name
  asg_scaling = {
    min = 1
    max = 1
    target = 1
  }
  subnet_ids = module.vpc.public_subnet_ids
  target_utilization = 90
  depends_on = [module.vpc, module.ecs_cluster]
}