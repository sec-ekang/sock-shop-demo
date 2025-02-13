output "zone_id" {
  description = "The ID of the Route53 hosted zone"
  value       = aws_route53_zone.this.zone_id
}

output "record_fqdn" {
  description = "Fully qualified DNS name of the created record"
  value       = aws_route53_record.app_record.fqdn
}