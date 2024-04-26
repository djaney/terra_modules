resource "aws_route_table" "nat" {
    vpc_id = var.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        network_interface_id = var.eni_id
    }

    tags = {
        Name = "${var.subnet.id} nat route"
    }

}
resource "aws_route_table_association" "private" {
    subnet_id      = var.subnet.id
    route_table_id = aws_route_table.nat.id

    depends_on = [aws_route_table.nat]
}