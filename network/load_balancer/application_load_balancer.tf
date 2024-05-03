
resource "aws_lb" "main" {
    name               = var.name
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.alb.id]
    subnets            = var.public_subnet_ids

    enable_deletion_protection = false
}