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