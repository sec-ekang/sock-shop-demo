output "jenkins_instance_id" {
  description = "Jenkins EC2 Instance ID"
  value       = aws_instance.jenkins.id
}

output "jenkins_public_ip" {
  description = "Public IP of the Jenkins instance"
  value       = aws_eip.jenkins_eip.public_ip
}