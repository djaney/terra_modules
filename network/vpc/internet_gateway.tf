resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Public"
  }
}

resource "aws_route" "public_igw" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

# Make IGW available in public subnets
resource "aws_route_table_association" "a" {
  for_each       = toset(aws_subnet.public[*].id)
  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}