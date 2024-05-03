resource "aws_ecs_task_definition" "service" {
    family                = "${var.name}-svc"
    task_role_arn         = var.task_role_arn
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
    network_mode = "bridge"
}