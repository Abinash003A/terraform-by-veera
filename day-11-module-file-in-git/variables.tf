variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  
}
variable "subnet_cidr_block" {
  description = "CIDR blocks for the subnets"
  type = object({
    subnet1_cidr_block = map(string)
    subnet2_cidr_block = map(string)
    })

}
variable "tags" {
  description = "Tags for the resources"
  type = object({
    vpc_tags     = map(string)
    subnet1_tags = map(string)
    subnet2_tags = map(string)
  })
}

variable "availability_zone" {
  description = "Availability zones for the subnets"
  type = object({
    subnet1_az = map(string)
    subnet2_az = map(string)
  })
}