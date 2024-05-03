resource "aws_lb_listener" "http" {
    count             = var.http.port > 0 ? 1 : 0
    load_balancer_arn = aws_lb.main.arn
    port              = var.http.port
    protocol          = "HTTP"

    default_action {
        type = "fixed-response"

        fixed_response {
            content_type = "text/plain"
            message_body = "Service Unavailable"
            status_code  = "503"
        }
    }
}

resource "aws_lb_listener" "https" {
    count             = var.https.port > 0 ? 1 : 0
    load_balancer_arn = aws_lb.main.arn
    port              = var.https.port
    protocol          = "HTTPS"
    ssl_policy        = "ELBSecurityPolicy-2016-08"
    certificate_arn   = var.https.certificate_arn

    default_action {
        type = "fixed-response"

        fixed_response {
            content_type = "text/plain"
            message_body = "Service Unavailable"
            status_code  = "503"
        }
    }
}