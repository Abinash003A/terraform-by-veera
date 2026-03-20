variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string 
}
variable "tags" {
  description = "Tags for the VPC"
  type        = object({
    vpc_tags = map(string)
  })
}
variable "my_subnet1_cidr_block" {
  description = "CIDR blocks for the subnets"
  type        = object({
    subnet1_cidr_block = string
  })
}
variable "my_subnet1_availability_zone" {
  description = "Availability zones for the subnets"
  type        = object({
    subnet1_az = string
  })
}
