locals {
  az_count = length(data.aws_availability_zones.available.names)
  az = data.aws_availability_zones.available
}

resource "aws_subnet" "public" {
    vpc_id     = aws_vpc.main.id

    count = local.az_count

    availability_zone = local.az.names[count.index]
    cidr_block = cidrsubnet(aws_vpc.main.cidr_block, var.subnet_bits, count.index + 1)
    tags = {
        Name = "Public ${local.az.names[count.index]}"
    }
}

resource "aws_subnet" "private" {
    vpc_id     = aws_vpc.main.id

    count = local.az_count
    
    availability_zone = local.az.names[count.index]
    cidr_block = cidrsubnet(aws_vpc.main.cidr_block, var.subnet_bits, local.az_count + count.index + 1)
    tags = {
        Name = "Private ${local.az.names[count.index]}"
    }
}