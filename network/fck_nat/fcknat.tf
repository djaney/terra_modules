module "nat" {
    source = "RaJiska/fck-nat/aws"

    name                 = "${var.nat_subnet_id}-fck-nat"
    vpc_id               = var.vpc_id
    subnet_id            = var.nat_subnet_id
    instance_type        = var.instance_type
    use_cloudwatch_agent = true 
    update_route_table   = true
    route_table_id       = var.route_table_id
}