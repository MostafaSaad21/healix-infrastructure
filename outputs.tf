output "cloudfront_domain" {
  description = "The Website URL (CDN)"
  value       = module.edge.cloudfront_domain_name
}

output "alb_dns" {
  description = "Direct Load Balancer URL (Origin)"
  value       = module.compute.alb_dns_name
}