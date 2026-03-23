variable "subnets" {
  type = map(object({
    
    cidr = string
    az = string
  }))
}

variable "vpc_id" {
  type = string
}