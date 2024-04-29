module "nat" {
    source = "RaJiska/fck-nat/aws"

    name                 = "${var.nat_subnet_id}-fck-nat"
    vpc_id               = var.vpc_id
    subnet_id            = var.nat_subnet_id
    instance_type        = var.instance_type
    use_cloudwatch_agent = true 
    update_route_table   = false
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  tags = {
    Name = "Fcknat-${var.nat_subnet_id}"
  }
}

resource "aws_route" "private" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = module.nat.eni_id
}

# Make NAT available in private subnets
resource "aws_route_table_association" "a" {
  count          = length(var.subnet_ids)
  subnet_id      = var.subnet_ids[count.index]
  route_table_id = aws_route_table.private.id
}