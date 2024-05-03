data "aws_availability_zones" "available" {
    state = "available"

    # only availability zones. No local
    filter {
        name   = "opt-in-status"
        values = ["opt-in-not-required"]
    }
}