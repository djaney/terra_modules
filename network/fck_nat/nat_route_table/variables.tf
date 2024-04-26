variable vpc {
  type        = map
  description = "VPC object"
}


variable subnet {
  type        = map
  description = "Subnet object"
}

variable eni_id {
  type        = string
  description = "Network interface id"
}
