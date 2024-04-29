output private_subnet_ids {
  value       = aws_subnet.private[*].id
  sensitive   = false
  description = "List of private subnets"
  depends_on  = [aws_subnet.private]
}

output main_route_table_id {
  value       = aws_vpc.main.main_route_table_id
  sensitive   = false
  description = "Main route table ID"
  depends_on  = [aws_vpc.main]
}

output public_subnet_ids {
  value       = aws_subnet.public[*].id
  sensitive   = false
  description = "List of public subnets"
  depends_on  = [aws_subnet.public]
}

output vpc_id {
  value       = aws_vpc.main.id
  description = "VPC ID"
  depends_on  = [aws_vpc.main]
}
