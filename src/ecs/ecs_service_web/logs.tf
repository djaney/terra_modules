resource "aws_cloudwatch_log_group" "main" {
  name = "ecs-service-${var.name}"
}