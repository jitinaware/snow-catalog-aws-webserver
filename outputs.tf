

output "awsvm_public_ip" {
  value = aws_instance.aws-vm[*].public_ip
}
