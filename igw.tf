resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.developer.id

  tags = merge(var.common_tags, var.igw_function_tags)
}