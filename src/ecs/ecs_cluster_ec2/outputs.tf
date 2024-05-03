output "instance_role_arn" {
    value = aws_iam_role.ecs_agent.arn
}

output "cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "cluster_id" {
  value = aws_ecs_cluster.main.id
}