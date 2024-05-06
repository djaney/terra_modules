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

module "rds_instance" {
    source = "../../src/storage/rds_instance"
    
    db_identifier = "rds-isntance"
    db_name = "mydatabase"
    engine = "mysql"
    engine_version = "8.0"
    subnet_ids = module.vpc.private_subnet_ids
    vpc_id = module.vpc.vpc_id
    ssm_namespace = "dbtest"
}


# Cluster
resource "aws_ecs_cluster" "cluster" {
    name = "test-cluster"
}

resource "aws_iam_role" "task_role" {
    name = "test_role"

    assume_role_policy = jsonencode({
        Version   = "2012-10-17"
        Statement = [
            {
                Action    = "sts:AssumeRole"
                Effect    = "Allow"
                Sid       = ""
                Principal = {
                    Service = "ecs-tasks.amazonaws.com"
                }
            },
        ]
    })
}

module "balancer" {
    source            = "../../src/network/load_balancer"
    vpc_id            = module.vpc.vpc_id
    name              = "test-balancer"
    public_subnet_ids = module.vpc.public_subnet_ids
    ingress_ports     = [80]
    http              = {
        port = 80
    }
    depends_on = [module.vpc]
}

module "service" {
    source            = "../../src/ecs/ecs_service_web"
    name              = "web-service"
    vpc_id            = module.vpc.vpc_id
    subnet_ids        = module.vpc.private_subnet_ids
    cluster_id        = aws_ecs_cluster.cluster.id
    image             = "chentex/go-rest-api"
    task_cpu          = 256
    task_memory       = 512
    container_port    = 8080
    task_role_arn     = aws_iam_role.task_role.arn
    load_balancer_arn = module.balancer.alb_arn
    http              = {
        priority     = 1
        listener_arn = module.balancer.http_listener_arn
    }
    fargate = true

    environment = [{
        name = "db_endpoint"
        value = module.rds_instance.endpoint
    },{
        name = "db_name"
        value = module.rds_instance.db_name
    }]

    secrets = [{
        name = "db_username"
        valueFrom = module.rds_instance.username_ssm_arn
    },{
        name = "db_password"
        valueFrom = module.rds_instance.password_ssm_arn
    }]

    health_check = {
        path                = "/test"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 10
        interval            = 60
        matcher             = "401,200"
    }

    depends_on = [module.balancer, aws_iam_role.task_role, aws_ecs_cluster.cluster, module.vpc]
}