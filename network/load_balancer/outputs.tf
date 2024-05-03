output "alb_arn" {
    value = aws_lb.main.arn
}

output "http_listener_arn" {
    value = var.http.port > 0 ? aws_lb_listener.http[0].arn : ""
}

output "https_listener_arn" {
    value = var.https.port > 0 ? aws_lb_listener.https[0].arn : ""
}