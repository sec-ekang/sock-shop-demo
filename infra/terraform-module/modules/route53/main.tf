resource "aws_route53_zone" "this" {
  name = var.domain_name
}

resource "aws_route53_record" "app_record" {
  zone_id = aws_route53_zone.this.zone_id
  name    = var.record_name   # This will create www.csrnet.nz when combined with the zone.
  type    = var.record_type
  ttl     = var.ttl
  records = var.records
}