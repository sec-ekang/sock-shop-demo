resource "aws_db_subnet_group" "this" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids

  tags = { Name = var.subnet_group_name }
}

resource "aws_db_instance" "this" {
  identifier             = var.db_identifier
  engine                 = "mysql"
  engine_version         = "8.0.35"
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  storage_type           = "gp2"
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.security_group_id]
  deletion_protection    = var.deletion_protection
  skip_final_snapshot    = true

  monitoring_interval = var.monitoring_interval

  username = var.username
  password = var.password

  tags = { Name = var.db_identifier }
}