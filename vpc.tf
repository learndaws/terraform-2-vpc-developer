resource "aws_vpc" "developer" {
  cidr_block       = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(var.common_tags, var.vpc_function_tags)
}

resource "aws_eip" "nat_gw_public_ip" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "outbound_internet" {
  allocation_id = aws_eip.nat_gw_public_ip.id
  subnet_id     = aws_subnet.roboshop_public[0].id

  tags = merge(var.common_tags, var.nat_gw_function_tags)

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.developer.id

  tags = merge(var.common_tags, var.rt_public_function_tags)
}

resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.developer.id

  tags = merge(var.common_tags, var.rt_private_function_tags)
}

resource "aws_route" "public_subnet_default_route" {
  route_table_id            = aws_route_table.rt_public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gw.id
}

resource "aws_route" "private_subnet_default_route" {
  route_table_id            = aws_route_table.rt_private.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.outbound_internet.id
}

resource "aws_route_table_association" "public_subnets" {
  count = length(var.public_cidr_subnets)
  subnet_id      = element(aws_subnet.roboshop_public[*].id, count.index)
  route_table_id = aws_route_table.rt_public.id
}

resource "aws_route_table_association" "private_subnets" {
  count = length(var.private_cidr_subnets)
  subnet_id      = element(aws_subnet.roboshop_private[*].id, count.index)
  route_table_id = aws_route_table.rt_private.id
}

resource "aws_route_table_association" "database_subnets" {
  count = length(var.database_cidr_subnets)
  subnet_id      = element(aws_subnet.roboshop_database[*].id, count.index)
  route_table_id = aws_route_table.rt_private.id
}



