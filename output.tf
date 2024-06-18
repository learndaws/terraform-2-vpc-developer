output "roboshop_us_east_1" {
    value = data.aws_availability_zones.roboshop_us_east_1_avail_az
}

output "vpc_id" {
  value = aws_vpc.developer.id
}

output "public_subnet_ids" {
  value = aws_subnet.roboshop_public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.roboshop_private[*].id
}

output "database_subnet_ids" {
  value = aws_subnet.roboshop_database[*].id
}
