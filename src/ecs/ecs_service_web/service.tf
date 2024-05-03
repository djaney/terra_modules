resource "aws_ecs_service" "ec2" {
    count           = !var.fargate ? 1 : 0
    name            = "${var.name}-svc"
    cluster         = var.cluster_id
    task_definition = aws_ecs_task_definition.service.arn
    desired_count   = var.task_count
    launch_type     = "EC2"

    load_balancer {
        target_group_arn = aws_lb_target_group.main.arn
        container_name   = "${var.name}-container"
        container_port   = var.container_port
    }
    depends_on = [aws_lb_target_group.main, aws_ecs_task_definition.service]
}

resource "aws_security_group" "fargate_service" {
    vpc_id = var.vpc_id
    count  = var.fargate ? 1 : 0
    ingress {
        from_port = 0
        to_port   = 0
        protocol  = "-1"
        self      = true
    }

    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_ecs_service" "fargate" {
    count           = var.fargate ? 1 : 0
    name            = "${var.name}-svc"
    cluster         = var.cluster_id
    task_definition = aws_ecs_task_definition.service.arn
    desired_count   = var.task_count
    launch_type     = "FARGATE"

    network_configuration {
        security_groups = aws_security_group.fargate_service[*].id
        subnets          = var.subnet_ids
        assign_public_ip = false
    }

    load_balancer {
        target_group_arn = aws_lb_target_group.main.arn
        container_name   = "${var.name}-container"
        container_port   = var.container_port
    }
    depends_on = [aws_lb_target_group.main, aws_ecs_task_definition.service]
}

