data "aws_availability_zones" "pro_az" {
  state = "available"
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

resource "aws_vpc" "pro_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
}

resource "aws_internet_gateway" "pro_gw" {
  vpc_id = aws_vpc.pro_vpc.id
}

resource "aws_subnet" "pro_sub" {
  count                   = var.subnet_count
  availability_zone       = data.aws_availability_zones.pro_az.names[count.index % var.az_count]
  vpc_id                  = aws_vpc.pro_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 2, count.index)
  map_public_ip_on_launch = true
}

resource "aws_route_table" "pro_rt" {
  vpc_id = aws_vpc.pro_vpc.id

}

resource "aws_route" "pro_route" {
  route_table_id         = aws_route_table.pro_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.pro_gw.id

}

resource "aws_route_table_association" "pro_rt_ass" {
  route_table_id = aws_route_table.pro_rt.id
  subnet_id      = element(aws_subnet.pro_sub.*.id, count.index)
  count          = var.subnet_count
}
