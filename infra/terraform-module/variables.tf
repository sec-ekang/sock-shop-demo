variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "custom-vpc"
}

variable "public_subnets" {
  description = "List of public subnet CIDRs (Subnet 1: Jenkins, Subnet 2: EKS, Subnet 3: NAT Gateway)"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_azs" {
  description = "Availability zones for the public subnets"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "private_subnets" {
  description = "List of private subnet CIDRs (Subnet 1: RDS, Subnet 2: EKS NodeGroup)"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "private_azs" {
  description = "Availability zones for the private subnets"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b"]
}

variable "eks_nodes_cidr_blocks" {
  description = "CIDR blocks allowed for EKS NodeGroup access (for RDS security group)"
  type        = list(string)
  default     = ["10.0.102.0/24"]
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "sock-shop-eks-cluster"
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.21"
}

variable "cluster_role_name" {
  description = "IAM role name for the EKS cluster"
  type        = string
  default     = "sock-shop-eks-cluster-role"
}

variable "cluster_policy_arns" {
  description = "Managed policy ARNs for the EKS cluster role"
  type        = list(string)
  default     = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  ]
}

variable "node_role_name" {
  description = "IAM role name for the EKS worker nodes"
  type        = string
  default     = "sock-shop-eks-node-role"
}

variable "node_policy_arns" {
  description = "Managed policy ARNs for the EKS node role"
  type        = list(string)
  default     = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  ]
}

variable "node_desired_capacity" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "node_max_capacity" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 4
}

variable "node_min_capacity" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 2
}

variable "max_unavailable" {
  description = "Maximum number of nodes that can be unavailable during update"
  type        = number
  default     = 1
}

variable "node_instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "lb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
  default     = "sock-shop-alb"
}

variable "lb_security_groups" {
  description = "Security group IDs for the ALB"
  type        = list(string)
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "target_group_name" {
  description = "Name of the ALB target group"
  type        = string
  default     = "sock-shop-tg"
}

variable "target_port" {
  description = "Target port for the ALB target group"
  type        = number
  default     = 80
}

variable "target_protocol" {
  description = "Target protocol for the ALB target group"
  type        = string
  default     = "HTTP"
}

variable "health_check_path" {
  description = "Health check path for the target group"
  type        = string
  default     = "/health"
}

variable "listener_port" {
  description = "Listener port for the ALB"
  type        = number
  default     = 80
}

variable "listener_protocol" {
  description = "Listener protocol for the ALB"
  type        = string
  default     = "HTTP"
}

variable "ecr_repository_name_carts" {
  description = "Name of the ECR repository for carts microservice"
  type        = string
  default     = "sockshop-carts"
}

variable "ecr_repository_name_orders" {
  description = "Name of the ECR repository for Orders microservice"
  type        = string
  default     = "sockshop-orders"
}

variable "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch log group"
  type        = string
  default     = "/aws/eks/sock-shop"
}

variable "cloudwatch_retention_in_days" {
  description = "Retention period for CloudWatch logs (in days)"
  type        = number
  default     = 7
}

variable "cloudwatch_tags" {
  description = "Tags for the CloudWatch log group"
  type        = map(string)
  default     = { Environment = "dev" }
}

variable "domain_name" {
  description = "Domain name for Route53 hosted zone"
  type        = string
  default     = "csrnet.nz"
}

variable "record_name" {
  description = "DNS record name (e.g., www)"
  type        = string
  default     = "www"
}

variable "record_type" {
  description = "Type of DNS record"
  type        = string
  default     = "A"
}

variable "record_ttl" {
  description = "TTL for the DNS record"
  type        = number
  default     = 300
}

variable "route53_records" {
  description = "List of record values (e.g., ALB DNS name)"
  type        = list(string)
}

# Jenkins-specific variables
variable "jenkins_ami_id" {
  description = "AMI ID for the Jenkins instance"
  type        = string
}

variable "jenkins_instance_type" {
  description = "EC2 instance type for Jenkins"
  type        = string
  default     = "t3.medium"
}

variable "jenkins_volume_size" {
  description = "Root volume size in GiB for the Jenkins instance"
  type        = number
  default     = 20
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

# RDS-specific variables
variable "rds_subnet_group_name" {
  description = "Name for the RDS subnet group"
  type        = string
  default     = "rds-subnet-group"
}

variable "rds_db_identifier" {
  description = "Identifier for the RDS instance"
  type        = string
  default     = "sock-shop-rds"
}

variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "rds_allocated_storage" {
  description = "Allocated storage in GiB for the RDS instance"
  type        = number
  default     = 20
}

variable "rds_deletion_protection" {
  description = "Enable deletion protection for the RDS instance"
  type        = bool
  default     = true
}

variable "rds_monitoring_interval" {
  description = "Enhanced monitoring interval in seconds for the RDS instance"
  type        = number
  default     = 60
}

variable "rds_username" {
  description = "Database username for the RDS instance"
  type        = string
}

variable "rds_password" {
  description = "Database password for the RDS instance"
  type        = string
  sensitive   = true
}