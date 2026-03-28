variable "ami_id" {
    description = "passing values to ami_id"
    default = ""
    type = string
  
}
variable "instance_type" {
    description = "passing values to instance_type"
    default = ""
    type = string
  
}
variable "env" {
    description = "environmentName"
    default = ["dev", "test", "prod"]
    type = list(string )
}
resource "aws_instance" "name" {
    # for_each = toset(var.env) #converted list to set
    for_each = { for env in var.env : env => env } #converted list to map
    ami = var.ami_id
    instance_type = var.instance_type
    tags = {
        Name = each.key
    }

}