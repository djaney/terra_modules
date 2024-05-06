output endpoint {
    value       = aws_db_instance.db.endpoint
    sensitive   = false
    description = "address:port"
    depends_on  = [aws_db_instance.db]
}

output username_ssm_arn {
    value       = aws_ssm_parameter.db_username.arn
    sensitive   = false
    description = "Username SSM ARN"
    depends_on  = [aws_db_instance.db]
}

output password_ssm_arn {
  value       = aws_ssm_parameter.db_password.arn
  sensitive   = true
  description = "Password SSM ARN"
  depends_on  = [aws_db_instance.db]
}

output db_name {
    value       = aws_db_instance.db.db_name
    sensitive   = false
    description = "Database name"
    depends_on  = [aws_db_instance.db]
}
