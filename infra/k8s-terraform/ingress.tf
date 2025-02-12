# Create the ingress-nginx namespace
resource "kubernetes_namespace" "ingress-nginx" {
  metadata {
    name = "ingress-nginx"
  }
}

# Use helm to create an nginx ingress controller
resource "helm_release" "ingress-nginx" {
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "ingress-nginx"
  create_namespace = false
  cleanup_on_fail = true
  force_update = true
  timeout = 6000

  set {
    name  = "controller.service.name"
    value = "ingress-nginx-controller"
  }

  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-connection-idle-timeout"
    value = "3600"
  }

  set {
    name  = "controller.publishService.enabled"
    value = "true"
  }

  set {
    name  = "controller.config.cleanup"
    value = "true"
  }

  set {
    name  = "controller.extraArgs.default-ssl-certificate"
    value = "sock-shop/${var.domain}-tls"
  }

  depends_on = [ kubernetes_namespace.ingress-nginx, kubernetes_namespace.sock-shop  ]
}

# Create an Ingress resource using the kubectl_manifest resource
resource "kubectl_manifest" "ingress" {
  depends_on = [ kubectl_manifest.cert_manager_cluster_issuer, kubectl_manifest.cert_manager_certificate ]
  yaml_body = <<YAML
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ingress
  namespace: sock-shop
  annotations:
    kubernetes.io/ingress.class: nginx
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
    certmanager.k8s.io/acme-challenge-type: dns01
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  tls:
  - hosts:
    - ${var.domain}
    - "www.${var.domain}"
  secretName: "${var.domain}-tls"
  rules:
  - host: ${var.domain}
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: front-end
            port:
              number: 80
  - host: "www.${var.domain}"
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: front-end
            port:
              number: 80
YAML
}

# Route 53 record creation so that our ingress controller can point to our domain name
resource "aws_route53_record" "ingress_load_balancer" {
  zone_id = data.aws_route53_zone.selected.zone_id  # Replace with your Route 53 Hosted Zone ID
  name    = var.domain # Replace with the DNS name you want
  type    = "A"

  # Use the LoadBalancer's external IP or DNS name
  alias {
    name                   = data.aws_elb.ingress_nginx_lb.dns_name
    zone_id                = data.aws_elb.ingress_nginx_lb.zone_id  # zone ID for the alias
    evaluate_target_health = true
  }
}

# Route 53 record creation so that our ingress controller can point to subdomains of our domain name
resource "aws_route53_record" "ingress_subdomain_load_balancer" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "*.${var.domain}"
  type    = "A"
  alias {
    name                   = data.aws_elb.ingress_nginx_lb.dns_name
    zone_id                = data.aws_elb.ingress_nginx_lb.zone_id
    evaluate_target_health = true
  }
}

# Create an Ingress resource using the kubectl_manifest resource for our monitoring resources
resource "kubectl_manifest" "ingress_monitoring" {
  depends_on = [ kubectl_manifest.cert_manager_cluster_issuer, null_resource.copy_secret ]
  yaml_body = <<YAML
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ingress
  namespace: monitoring
  annotations:
    kubernetes.io/ingress.class: nginx
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
    certmanager.k8s.io/acme-challenge-type: dns01
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  tls:
  - hosts:
    - "prometheus.${var.domain}"
    - "grafana.${var.domain}"
    - "alertmanager.${var.domain}"
  secretName: "${var.domain}-tls"
  rules:
  - host: "prometheus.${var.domain}"
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: prometheus
            port:
              number: 9090
  - host: "grafana.${var.domain}"
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: grafana
            port:
              number: 80
  - host: "alertmanager.${var.domain}"
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: alertmanager
            port:
              number: 9093
YAML
}

# Create kube-logging namespace
resource "kubernetes_namespace" "kube-logging" {
  metadata {
    name = "kube-logging"
  }
}

# Create an Ingress resource using the kubectl_manifest resource for kibana
resource "kubectl_manifest" "ingress_kibana" {
  depends_on = [ kubectl_manifest.cert_manager_cluster_issuer, null_resource.copy_secret_kibana, kubernetes_namespace.kube-logging ]
  yaml_body = <<YAML
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ingress
  namespace: kube-logging
  annotations:
    kubernetes.io/ingress.class: nginx
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
    certmanager.k8s.io/acme-challenge-type: dns01
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  tls:
  - hosts:
    - "kibana.${var.domain}"
  secretName: "${var.domain}-tls"
  rules:
  - host: "kibana.${var.domain}"
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: kibana
            port:
              number: 5601
YAML
}