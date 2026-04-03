
output "address" {
  value = aws_db_instance.example.address
  description = "connect to db at this addr"
}

output "port" {
  value = aws_db_instance.example.port
  description = "that's not port, it's sherry!"
}

output "arn" {
  value = aws_db_instance.example.arn
  description = "ARN of the db"
}
