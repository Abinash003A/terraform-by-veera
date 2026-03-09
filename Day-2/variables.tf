variable "ami_id" {
    description = "The AMI ID to use for the instance"
    default = ""
    type = string
}
variable "instance_type" {
    description = "The type of instance to use"
    default = "t2.medium"
    type = string
  
}