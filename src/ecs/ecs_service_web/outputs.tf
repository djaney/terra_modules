output "target_group_arn" {
    value = aws_lb_target_group.main.arn
}

output "service_id" {
    value = var.fargate ? aws_ecs_service.fargate[0].id : aws_ecs_service.ec2[0].id
}