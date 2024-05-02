resource "aws_kms_key" "log" {
  description             = "${var.name}-logs-key"
  deletion_window_in_days = 7
}

resource "aws_cloudwatch_log_group" "main" {
  name = "${var.name}-logs"
}

resource "aws_ecs_cluster" "main" {
  name = var.name

  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.log.arn
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.main.name
      }
    }
  }
}