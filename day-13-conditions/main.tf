variable "env"{
    type = string
    default = "test"

    #to ensure only valid input will be accepted
    validation {
    condition     = contains(["dev", "test", "prod"], var.env)
    error_message = "env must be dev, test or prod"
  }

}
resource "aws_instance" "name" {
    ami = "ami-02dfbd4ff395f2a1b"
    instance_type = "t2.micro"
#we are providing condition here
# if variable value is true then create 2 instance if false then create 1 instance
#Ex-
#terraform apply -var="env=dev" #this will create 1 instance
#terraform apply -var="env=prod" #this will create 2 instance
    count = var.env == "prod" ? 2: 1
    tags = {
        Name = "my-ec2-instance-${count.index}"
    }
  
}
