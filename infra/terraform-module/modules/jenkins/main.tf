resource "aws_instance" "jenkins" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids = [var.security_group_id]

  root_block_device {
    volume_size = var.volume_size
    volume_type = "gp2"
  }

  tags = { Name = var.name }
}

resource "aws_eip" "jenkins_eip" {
  instance = aws_instance.jenkins.id
  vpc      = true
}