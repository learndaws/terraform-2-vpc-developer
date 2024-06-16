resource "aws_subnet" "roboshop_public" {
  count = length(var.public_cidr_subnets)
  vpc_id     = aws_vpc.developer.id
  cidr_block = var.public_cidr_subnets[count.index]
  availability_zone = local.availability_zone[count.index]

  tags = merge(var.common_tags, var.public_subnet_function_tags)
}

resource "aws_subnet" "roboshop_private" {
  count = length(var.private_cidr_subnets)
  vpc_id     = aws_vpc.developer.id
  cidr_block = var.private_cidr_subnets[count.index]
  availability_zone = local.availability_zone[count.index]

  tags = merge(var.common_tags, var.private_subnet_function_tags)
}

resource "aws_subnet" "roboshop_database" {
  count = length(var.database_cidr_subnets)
  vpc_id     = aws_vpc.developer.id
  cidr_block = var.database_cidr_subnets[count.index]
  availability_zone = local.availability_zone[count.index]

  tags = merge(var.common_tags, var.database_subnet_function_tags)
}

resource "aws_db_subnet_group" "default" {
  name       = "database_subnet_group"
  subnet_ids = aws_subnet.roboshop_database[*].id

  tags = {
    Name = "database_subnet_group"
  }
}

resource "aws_eip" "eip" {
  domain           = "vpc"
}