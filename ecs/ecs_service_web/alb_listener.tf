resource "aws_lb_listener_rule" "https" {
    count        = var.https.priority >= 0 ? 1 : 0
    listener_arn = var.https.listener_arn
    priority     = 1

    action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.main.arn
    }


    condition {
        path_pattern {
            values = ["*"]
        }
    }

    tags = {
        Name = "${var.name} HTTPS Listener"
    }
}
resource "aws_lb_listener_rule" "http" {
    count        = var.http.priority >= 0 ? 1 : 0
    listener_arn = var.http.listener_arn
    priority     = 2

    action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.main.arn
    }


    condition {
        path_pattern {
            values = ["*"]
        }
    }

    tags = {
        Name = "${var.name} HTTP Listener"
    }
}