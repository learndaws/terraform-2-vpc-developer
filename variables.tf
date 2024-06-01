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