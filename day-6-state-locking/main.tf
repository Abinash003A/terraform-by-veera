resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "dev2-vpc"
  }
}
resource "aws_subnet" "name" {
  vpc_id     = aws_vpc.name.id
  cidr_block = "10.0.0.0/26"
    tags = {
        Name = "my-dev2-subnet"
    }
}
resource "aws_instance" "name" {
    ami           = "ami-02dfbd4ff395f2a1b"
    instance_type = "t2.micro"
    subnet_id     = aws_subnet.name.id
    tags = {
        Name = "dev2-instance"
    }
  
}