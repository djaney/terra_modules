output endpoint {
    value       = aws_db_instance.db.endpoint
    sensitive   = false
    description = "address:port"
    depends_on  = [aws_db_instance.db]
}

output username {
    value       = aws_db_instance.db.username
    sensitive   = false
    description = "Username"
    depends_on  = [aws_db_instance.db]
    }

output password {
  value       = aws_db_instance.db.password
  sensitive   = true
  description = "address:port"
  depends_on  = [aws_db_instance.db]
}

output db_name {
    value       = aws_db_instance.db.db_name
    sensitive   = false
    description = "Database name"
    depends_on  = [aws_db_instance.db]
}
