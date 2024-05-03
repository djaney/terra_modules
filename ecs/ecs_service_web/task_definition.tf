resource "aws_iam_role" "execution" {
    name = "${var.name}-task-exec"

    # Required by log aws log driver
    inline_policy {
        name   = "logs"
        policy = jsonencode({
            Version   = "2012-10-17"
            Statement = [
                {
                    Action   = ["logs:CreateLogStream", "logs:PutLogEvents", "logs:CreateLogGroup"]
                    Effect   = "Allow"
                    Resource = "*"
                },
            ]
        })
    }


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

resource "aws_ecs_task_definition" "service" {
    family                = "${var.name}-svc"
    task_role_arn         = var.task_role_arn
    execution_role_arn    = aws_iam_role.execution.arn
    container_definitions = templatefile(
        "${path.module}/task_definition.json.tpl",
        {
            task_definition_name = "${var.name}-container"
            image                = var.image
            task_cpu             = var.task_cpu
            task_memory          = var.task_memory
            container_port       = var.container_port
            environment          = jsonencode(var.environment)
            secrets              = jsonencode(var.secrets)
            region               = data.aws_region.current.name
            cloudwatch_group     = aws_cloudwatch_log_group.main.name
        }
    )
    requires_compatibilities = var.fargate ? ["FARGATE"] : ["EC2"]
    cpu                      = var.task_cpu
    memory                   = var.task_memory
    network_mode             = var.fargate ? "awsvpc" : "bridge"
}