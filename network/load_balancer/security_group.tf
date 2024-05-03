resource "aws_security_group" "alb" {
    vpc_id = var.vpc_id

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

resource "aws_vpc_security_group_ingress_rule" "ingress" {
    security_group_id = aws_security_group.alb.id
    count          = length(var.ingress_ports)
    cidr_ipv4         = "0.0.0.0/0"
    from_port         = var.ingress_ports[count.index]
    ip_protocol       = "tcp"
    to_port           = var.ingress_ports[count.index]
}