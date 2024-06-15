variable "cidr_block" {
    type = string 
    default = "10.0.0.0/16"
}       

variable "enable_dns_hostnames" {
    type = bool
    default = "true"
}

variable "common_tags" {
    type = map
    default = {
        Project = "Roboshop"
        Environment = "Dev"
        Terraform = "True"
        Name = "common_function"
    }
}

variable "vpc_function_tags" {
    type = map
}

variable "igw_function_tags" {
    type = map
}

variable "public_subnet_function_tags" {
    type = map
}

variable "private_subnet_function_tags" {
    type = map
}

variable "database_subnet_function_tags" {
    type = map
}

variable "nat_gw_function_tags" {
    type = map
}

variable "rt_public_function_tags" {
    type = map
}

variable "rt_private_function_tags" {
    type = map
}

variable "public_cidr_subnets" {

        validation {
        condition = length(var.public_cidr_subnets) == 2
        error_message = "Please give 2 public valid subnet CIDR"
    }
}

variable "private_cidr_subnets" {

        validation {
        condition = length(var.private_cidr_subnets) == 2
        error_message = "Please give 2 private valid subnet CIDR"
    }
}

variable "database_cidr_subnets" {

        validation {
        condition = length(var.database_cidr_subnets) == 2
        error_message = "Please give 2 private valid subnet CIDR"
    }
}