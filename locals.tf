locals {
    us_east_1_first_2_az = slice(data.aws_availability_zones.roboshop_us_east_1_avail_az.names,0,2)
    availability_zone = slice(data.aws_availability_zones.roboshop_us_east_1_avail_az.names,2,4)
}