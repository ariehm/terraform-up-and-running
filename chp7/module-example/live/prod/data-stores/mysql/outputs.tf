
output "primary_address" {
  value       = module.mysql_primary.address
  description = "connect to primary db at this endpoint"
}

output "primary_port" {
  value       = module.mysql_primary.port
  description = "port of primary db"
}

output "primary_arn" {
  value       = module.mysql_primary.arn
  description = "primary arn"
}

output "replica_address" {
  value       = module.mysql_replica.address
  description = "connect to replica at this address"
}

output "replica_port" {
  value       = module.mysql_replica.port
  description = "port of replica db"
}

output "replica_arn" {
  value       = module.mysql_replica.arn
  description = "replica arn"
}
