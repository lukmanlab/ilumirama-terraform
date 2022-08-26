output name {
  value       = aws_instance.app_server.tags.Name
}

output id {
  value       = aws_instance.app_server.id
}

output private_ip {
  value       = aws_instance.app_server.private_ip
}

output public_ip {
  value       = aws_instance.app_server.public_ip
}

