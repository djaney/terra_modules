output private_subnets {
  value       = aws_subnet.private
  sensitive   = false
  description = "List of private subnets"
  depends_on  = [aws_subnet.private]
}

output public_subnets {
  value       = aws_subnet.public
  sensitive   = false
  description = "List of public subnets"
  depends_on  = [aws_subnet.public]
}

output vpc {
  value       = aws_vpc.main
  description = "VPC object"
  depends_on  = [aws_vpc.main]
}
