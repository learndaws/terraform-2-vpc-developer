resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.developer.id

  tags = merge(var.common_tags, var.igw_function_tags)
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