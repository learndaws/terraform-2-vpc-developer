output "roboshop_us_east_1" {
    value = data.aws_availability_zones.roboshop_us_east_1_avail_az
}

output "deletelater" {
    value = data.aws_vpc.default
}