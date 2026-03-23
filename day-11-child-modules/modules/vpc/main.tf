#vpc resource block
resource "aws_vpc" "this" {
    cidr_block = var.vpc.cidr
    tags       = var.vpc.tags
}