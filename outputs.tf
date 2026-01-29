output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = "http://${aws_lb.main.dns_name}"
}

output "database_endpoint" {
  description = "The endpoint of the database"
  value       = aws_db_instance.wordpress_db.address
}
