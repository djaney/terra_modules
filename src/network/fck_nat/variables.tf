variable vpc_id {
  type        = string
  description = "VPC object"
}

variable nat_subnet_id {
  type        = string
  description = "Subnet to put NAT"
}

variable subnet_ids {
  type        = list(string)
  description = "List of private subnets"
}

variable "instance_type" {
  description = "Instance type to use for the NAT instance"
  type        = string
  default     = "t4g.nano"
}