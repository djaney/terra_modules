[
  {
    "name": "${task_definition_name}",
    "image": "${image}",
    "cpu": ${task_cpu},
    "memory": ${task_memory},
    "essential": true,
    "environment": ${environment},
    "secrets": ${secrets},
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${cloudwatch_group}",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]