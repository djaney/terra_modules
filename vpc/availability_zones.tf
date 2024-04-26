data "aws_availability_zone" "available" {
    state = "available"
    filter {
        name = "zone_type"
        values = ["availability-zone"]
    }
}