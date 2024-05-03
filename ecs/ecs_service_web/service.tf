resource "aws_ecs_service" "main" {
  name            = "${var.name}-svc"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.service.arn
  desired_count   = var.task_count

  load_balancer {
    target_group_arn = aws_lb_target_group.main.arn
    container_name   = "${var.name}-container"
    container_port   = var.container_port
  }
  depends_on = [aws_lb_target_group.main, aws_ecs_task_definition.service]
}

