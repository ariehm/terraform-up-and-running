
output "region_1" {
  value       = data.aws_region.region_1.name
  description = "name of first region"
}

output "region_2" {
  value       = data.aws_region.region_2.name
  description = "name of second region"
}

output "instance_region_1_az" {
  value       = aws_instance.region_1.availability_zone
  description = "where the first at"
}

output "instance_region_2_az" {
  value       = aws_instance.region_2.availability_zone
  description = "where the second at"
}
