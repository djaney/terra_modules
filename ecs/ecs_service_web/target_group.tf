resource "aws_lb_target_group" "main" {
    name     = "${var.name}-tgp"
    protocol = var.protocol
    port     = var.container_port
    vpc_id   = var.vpc_id

    health_check {
        path                = var.health_check.path
        healthy_threshold   = var.health_check.healthy_threshold
        unhealthy_threshold = var.health_check.unhealthy_threshold
        timeout             = var.health_check.timeout
        interval            = var.health_check.interval
        matcher             = var.health_check.matcher
    }
}


