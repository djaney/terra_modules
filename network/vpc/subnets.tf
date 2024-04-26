locals {
  az_numbers = {
    a = 1
    b = 2
    c = 3
    d = 4
    e = 5
    f = 6
  }
  az_count = length(data.aws_availability_zone.available)
}

resource "aws_subnet" "public" {
    vpc_id     = aws_vpc.main.id

    for_each = data.aws_availability_zone.available

    availability_zone = each.value.name
    cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, local.az_numbers[each.value.name_suffix])
    tags = {
        Name = "Public ${each.value.name_suffix}"
    }
}

resource "aws_subnet" "private" {
    vpc_id     = aws_vpc.main.id

    for_each = data.aws_availability_zone.available
    
    availability_zone = each.value.name
    cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, local.az_count + local.az_numbers[each.value.name_suffix])
    tags = {
        Name = "Private ${each.value.name_suffix}"
    }
}