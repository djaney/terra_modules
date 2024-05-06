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
resource "aws_ecs_cluster" "cluster" {
    name = "test-cluster"
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

# Create web service
module "service" {
    source            = "../../src/ecs/ecs_service_worker"
    name              = "web-worker"
    vpc_id            = module.vpc.vpc_id
    subnet_ids        = module.vpc.private_subnet_ids
    cluster_id        = aws_ecs_cluster.cluster.id
    image             = "willfarrell/ping"
    task_cpu          = 256
    task_memory       = 512
    container_port    = 8080
    task_role_arn     = aws_iam_role.task_role.arn
    fargate = true

    environment = [{
        name = "HOSTNAME"
        value = "google.com"
    }]

    depends_on = [aws_iam_role.task_role, aws_ecs_cluster.cluster, module.vpc]
}