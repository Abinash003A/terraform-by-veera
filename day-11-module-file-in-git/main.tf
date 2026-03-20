resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = var.tags.vpc_tags
}
resource "aws_subnet" "my_subnet1_cidr_block" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.cidr_block.subnet1_cidr_block
  availability_zone = var.availability_zone.subnet1_az
}