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

# # option-1
# resource "aws_instance" "ec2" {
#     ami = var.ami_id
#     instance_type = var.instance_type
#     # count = 2
#     #     tags = {
#     #         Name = "my-ec2-instance"  #instance with same name will be created
#     #     }

#     # count=2
#     # tags = {
#     #   Name = "dev_instance_${count.index}_ec2" #instance with different name will be created according to index"key" = 
#     # }

# }

variable "env" {
    description = "environmentName"
    # default = ["dev", "test", "prod"]
    #problem we face in indexing the list
    #if we dont want test ec2 and only dev and prod while all 3 are created
    default = ["dev", "prod"] #here orignal prod will be deleted and test will be renamed as prod beacause of indexing
    type = list(string)
}

# option -2
resource "aws_instance" "ec2" {
    ami = var.ami_id
    instance_type = var.instance_type
    count = length(var.env)
    tags = {
        Name = var.env[count.index] #number of environments written in env will be created
    }
}

