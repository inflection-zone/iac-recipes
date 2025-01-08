output "ec2-instance-public-ip" {
  description = "ec2-instance public ip"
  value       = module.ec2.ec2-instance-public-ip
}