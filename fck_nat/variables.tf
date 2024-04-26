variable vpc {
  type        = map
  description = "VPC object"
}

variable subnets {
  type        = list
  description = "List of private subnets"
}

variable one_nat_for_each_subnet {
  type        = bool
  default     = false
  description = "True if each private subnet gets it's own NAT gateway"
}
