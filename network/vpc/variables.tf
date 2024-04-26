variable cidr {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR"
}

variable subnet_bits {
  type        = number
  default     = 8
  description = "Bits to allocate for subnets."
}