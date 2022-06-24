output "ec2-public_ip" {
  value = aws_instance.quick-ec2_ubuntu.public_ip
}
output "codecommit_repo_clone_url_http" {
    value = aws_codecommit_repository.angular_repo.clone_url_http
 
}