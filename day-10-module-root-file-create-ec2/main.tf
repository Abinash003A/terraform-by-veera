module "name" {
  source = "../day-10-root-file"
  ami_id = "ami-02dfbd4ff395f2a1b" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t2.micro"
  tags = {
    terraform = "true"
    Environment = "dev"
    # Name = "abinash-ec2-instance"
  }
}