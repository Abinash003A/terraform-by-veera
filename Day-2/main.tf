resource "aws_instance" "bastion_ec2_1" {
    ami = var.ami_id
    instance_type = var.instance_type
    tags = {
        Name = "My-tf-bastion-instance-1"
    }
}
resource "aws_instance" "bastion_ec2_2" {
    ami = var.ami_id
    instance_type = var.instance_type
    tags = {
        Name = "My-tf-bastion-instance-2"
    }
}