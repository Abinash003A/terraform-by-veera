module "s3-bucket" {
source  = "terraform-aws-modules/s3-bucket/aws"
version = "5.10.0"      #module version
bucket = "abinash-terraform-bucket-505060"
}

module "ec2-instance" {
source  = "terraform-aws-modules/ec2-instance/aws"
version = "6.3.0"       #module version
name = "my-ec2-instance"
ami = "ami-02dfbd4ff395f2a1b"
instance_type = "t2.micro"
subnet_id = "subnet-016a4fbed17bb0f15"
}