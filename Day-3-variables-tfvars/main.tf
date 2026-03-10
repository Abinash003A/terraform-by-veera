resource "aws_instance" "prod_ec2" {
    provider = aws.prod
  ami           = var.prod_ami_id
  instance_type = var.prod_instance_type
  tags = {
    Name = "prod_ec2"
  }
  
}

resource "aws_instance" "test_ec2" {
    provider = aws.test
  ami           = var.test_ami_id
  instance_type = var.test_instance_type
  subnet_id = "subnet-0ae357bf4046a64ea"
  tags = {
    Name = "test_ec2"
  }
  
}