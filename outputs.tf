output "stack_name" {
  value       = aws_appstream_stack.stack.name
  description = "Stack name."
}

output "fleet_name" {
  value       = aws_appstream_fleet.fleet.name
  description = "Fleet name."
}

output "ip_table" {
  value       = aws_dynamodb_table.ip.name
  description = "The name of the IP-gating DynamoDB table."
}

output "email_table" {
  value       = aws_dynamodb_table.email.name
  description = "The name of the email-gating DynamoDB table."
}

output "image_name" {
  value       = var.image_name
  description = "The name of the image for instances."
}

output "auth_type" {
  value       = var.auth_type
  description = "User authentication type for all operations."
}
