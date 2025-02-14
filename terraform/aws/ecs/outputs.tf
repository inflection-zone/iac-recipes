output "ecr-repository-url" {
  description = "ecr repository url"
  value       = module.ecr-repository.ecr-repository-url
}

output "rds-db-address" {
  description = "rds db host address"
  value       = module.rds.rds-db-address
}

output "bastion-host-ip" {
  description = "bastion host ip address"
  value       = module.rds.bastion-host-public-ip
}

output "load-balancer-dns" {
  description = "load balancer dns"
  value       = module.load-balancer.lb-dns-name
}