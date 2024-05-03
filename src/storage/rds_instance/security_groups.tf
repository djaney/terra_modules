resource "aws_security_group" "allow_db_access" {
  name        = "${var.db_identifier}_allow"
  description = "Open DB ports"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.db_identifier}_allow"
  }
}


resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.allow_db_access.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "allow_mysql" {
  security_group_id = aws_security_group.allow_db_access.id
  cidr_ipv4         = data.aws_vpc.main.cidr_block
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}

resource "aws_vpc_security_group_ingress_rule" "allow_postgres" {
  security_group_id = aws_security_group.allow_db_access.id
  cidr_ipv4         = data.aws_vpc.main.cidr_block
  from_port         = 5432
  ip_protocol       = "tcp"
  to_port           = 5432
}