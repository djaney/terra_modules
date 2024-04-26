# TODO separate this code so we can interchange it with gateway service
module "nat" {

    count = var.one_nat_for_each_subnet ? length(var.subnets) : 1

    source = "RaJiska/fck-nat/aws"

    name                 = "${var.subnets[count.index].id}-fck-nat"
    vpc_id               = var.vpc.id
    subnet_id            = var.subnets[count.index].id
    use_cloudwatch_agent = true 
}

module "nat_route" {
    source = "./nat_route_table"
    vpc = var.vpc

    count = length(var.subnets)

    subnet = var.subnets[count.index]
    eni_id = var.one_nat_for_each_subnet ? module.nat[count.index].eni_id : module.nat[0]

}