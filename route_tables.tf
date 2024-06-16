resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.developer.id

  tags = merge(var.common_tags, var.rt_public_function_tags)
}

resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.developer.id

  tags = merge(var.common_tags, var.rt_private_function_tags)
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