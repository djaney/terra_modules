resource "aws_db_subnet_group" "main" {
    name       = "${var.db_identifier}-sng"
    subnet_ids = var.subnet_ids
}