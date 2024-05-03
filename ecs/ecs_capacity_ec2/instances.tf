resource "aws_iam_instance_profile" "ecs_agent" {
  name = "${var.cluster_name}-ecs-agt"
  role = aws_iam_role.ecs_agent.name
}

resource "aws_launch_template" "engine" {
  name          = "${var.cluster_name}-tmpl"
  image_id      = local.ecs_image_ami_id
  instance_type = var.instance_type
  user_data     = base64encode("#!/bin/bash\necho ECS_CLUSTER=${var.cluster_name} >> /etc/ecs/ecs.config")

  vpc_security_group_ids = [aws_security_group.ecs_sg.id]
  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_agent.name
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "ECS - ${var.cluster_name}"
    }
  }
}


resource "aws_autoscaling_group" "main" {
  name = "${var.cluster_name}-asg"
  min_size = var.asg_scaling.min
  max_size = var.asg_scaling.max
  desired_capacity = var.asg_scaling.target
  vpc_zone_identifier = var.subnet_ids

  launch_template {
    id = aws_launch_template.engine.id
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}

resource "aws_ecs_capacity_provider" "main" {
  name = "${var.cluster_name}-capacity"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.main.arn
    managed_termination_protection = var.managed_termination_protection ? "ENABLED" : "DISABLED"

    managed_scaling {
      status                    = "ENABLED"
      target_capacity           = var.target_utilization
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "providers" {
  cluster_name       = var.cluster_name
  capacity_providers = [aws_ecs_capacity_provider.main.name]
}