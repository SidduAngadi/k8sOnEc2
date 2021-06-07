output "vpc_id" {
  value = module.vpc.vpc_id
}

# Subnets
output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "public_cidr_block" {
  value = module.vpc.public_cidr_block
}