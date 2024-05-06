provider "aws" {
    region = "ap-southeast-1"
}
module "vpc" {
    source = "../../src/network/vpc"
    name   = "Test"
}

# Nat
module "nat" {
    source        = "../../src/network/fck_nat"
    vpc_id        = module.vpc.vpc_id
    nat_subnet_id = module.vpc.public_subnet_ids[0]
    subnet_ids    = module.vpc.private_subnet_ids

    depends_on = [module.vpc]
}


# Define cluster

# Add capacity provider
module "cluster" {
    source       = "../../src/ecs/ecs_cluster_ec2"
    vpc_id       = module.vpc.vpc_id
    cluster_name = "test-cluster"
    asg_scaling  = {
        min    = 1
        max    = 1
        target = 1
    }
    subnet_ids         = module.vpc.private_subnet_ids
    target_utilization = 90
    depends_on         = [module.vpc]
}

# Dummy task role
# Add necessary permissions depending on your application
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

# Create balancer
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


# Create web service
module "service" {
    source            = "../../src/ecs/ecs_service_web"
    name              = "web-service"
    vpc_id            = module.vpc.vpc_id
    subnet_ids        = module.vpc.private_subnet_ids
    cluster_id        = module.cluster.cluster_id
    image             = "chentex/go-rest-api"
    task_cpu          = 512
    task_memory       = 512
    container_port    = 8080
    task_role_arn     = aws_iam_role.task_role.arn
    load_balancer_arn = module.balancer.alb_arn
    fargate           = false
    http              = {
        priority     = 1
        listener_arn = module.balancer.http_listener_arn
    }

    health_check = {
        path                = "/test"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 10
        interval            = 60
        matcher             = "401,200"
    }

    depends_on = [module.balancer, aws_iam_role.task_role, module.cluster, module.vpc]
}