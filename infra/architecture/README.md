# AWS Architecture

# AWS Cloud Architecture

- **VPC**
  - **Custom VPC**
    - **Internet Gateway:** Attached to VPC
    - **Subnets:**
      - **Public Subnets:**
        - **Subnet 1:** For Jenkins Instance
        - **Subnet 2:** For EKS Cluster
        - **Subnet 3:** For Load Balancer (Revised from NAT Gateway)
      - **Private Subnets:**
        - **Subnet 1:** For RDS
        - **Subnet 2:** For EKS NodeGroup
        - **Subnet 3:** For Backend Microservices
    - **NAT Gateway:** Moved to Multi-AZ Deployment for High Availability
    - **Route Tables:**
      - **Public Route Table:** Routes internet traffic via Internet Gateway
      - **Private Route Table:** Routes internet traffic via NAT Gateway
    - **Security Groups:**
      - **Jenkins Security Group:**
        - **Allows:**
          - SSH (port 22) from specific IPs
          - HTTPS (port 443) for secure web access
        - **Associated with:** Jenkins EC2 Instance
      - **RDS Security Group:**
        - **Allows:**
          - Connections from EKS NodeGroup
          - Connections from Jenkins Instance
        - **Restricts:** All other access
      - **EKS Security Group:**
        - **Allows:**
          - Node-to-Node Communication
          - Ingress from Load Balancer

- **EC2**
  - **Jenkins Instance:**
    - **Instance Type:** t3.small (Cost-Optimized)
    - **Storage:** 20 GiB
    - **Deployed in:** Public Subnet 1
    - **Elastic IP:** Assigned for consistent public access
    - **Security Group:** Jenkins Security Group

- **RDS**
  - **MySQL Database:**
    - **Engine:** MySQL 8.0.35
    - **Instance Class:** db.t4g.micro (Cost-Effective ARM-Based Instance)
    - **Storage:** 30 GiB (Cost-Optimized with Scalability)
    - **Multi-AZ:** Enabled for High Availability
    - **Deployed in:** Private Subnet 1
    - **Security Group:** RDS Security Group
    - **CloudWatch:** Enabled for monitoring
    - **Deletion Protection:** Enabled
    - **Encryption:** Enabled (KMS Managed Keys)

- **EKS**
  - **Elastic Kubernetes Service:**
    - **Cluster:** Deployed in Public Subnet 2
    - **NodeGroup:**
      - **Instance Type:** t3.medium
      - **Desired Capacity:** 2 nodes
      - **Min Capacity:** 2 nodes
      - **Max Capacity:** 4 nodes
      - **Max Unavailable:** 1 node
      - **Deployed in:** Private Subnet 2
      - **Accesses internet via:** NAT Gateway
    - **Add-ons:**
      - **CoreDNS:** Enabled
      - **Kube-Proxy:** Enabled
      - **VPC-CNI:** Enabled
      - **EKS Pod Identity Agent:** Enabled
    - **CloudWatch Log Group:** Configured for logging
    - **Encryption:** Enabled for EKS Secrets (KMS Managed Keys)

- **ALB**
  - **Application Load Balancer:**
    - **Deployed in:** Public Subnet 3
    - **Listener:**
      - **Port:** 80
      - **Protocol:** HTTP
      - **Default Action:** Forward traffic to Target Group
    - **Target Group:**
      - **Name:** Target Group
      - **Port:** 80
      - **Protocol:** HTTP
      - **Health Check Path:** /health
    - **Security:** Associated with ALB Security Group

- **CloudWatch**
  - **Log Groups:**
    - **EKS Log Group:** Configured for logging with retention policy
    - **RDS Monitoring:** Enabled with Enhanced Monitoring
  - **Metrics:** Aggregated metrics from EKS, RDS, and other services

- **Route53**
  - **Hosted Zone:** csrnet.nz
  - **DNS Record:**
    - **Record Name:** www
    - **Type:** A
    - **TTL:** 300 seconds
    - **Points to:** ALB DNS name

- **IAM Roles**
  - **Description:** Defined for EC2, EKS, and RDS
  - **Policies:**
    - **Least Privilege:** Applied
    - **Cross-Service Access:** Enabled with Specific Roles

- **ECR**
  - **Elastic Container Registry:**
    - **Repositories:**
      - **paperple-spring:** Frontend Image
      - **paperple-ai:** Backend Image
    - **Scan on Push:** Enabled
    - **Encryption:** Enabled (KMS Managed Keys)