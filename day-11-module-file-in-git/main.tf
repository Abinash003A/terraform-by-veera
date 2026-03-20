resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
  tags       = var.tags.vpc_tags
  
}
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_cidr_block.subnet1_cidr_block
  availability_zone = var.availability_zone.subnet1_az
  tags              = var.tags.subnet1_tags
  
}
resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_cidr_block.subnet2_cidr_block
  availability_zone = var.availability_zone.subnet2_az
  tags              = var.tags.subnet2_tags
  
}