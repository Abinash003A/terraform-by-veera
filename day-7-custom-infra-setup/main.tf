#Creating a VPC using Terraform
resource "aws_vpc" "vpc_identifier" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "My-1st-vpc-tf"
    }
}

#Creating a public subnet-1 using Terraform
resource "aws_subnet" "public_subnet_1" {
    vpc_id = aws_vpc.vpc_identifier.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "public-subnet-tf-1"
    }
}
#Creating a private subnet-1 using Terraform
resource "aws_subnet" "private_subnet_1" {
    vpc_id = aws_vpc.vpc_identifier.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "private-subnet-tf-1"
    }
}
#Creating a private subnet-2 using Terraform
resource "aws_subnet" "private_subnet_2" {
    vpc_id = aws_vpc.vpc_identifier.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "us-east-1b"
    tags = {
      Name = "private-subnet-tf-2"
    }
}

#Creating an Internet Gateway using Terraform
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc_identifier.id
    tags = {
      Name = "igw-tf"
    }
}

#Creating an Elastic IP for NAT Gateway using Terraform
resource "aws_eip" "nat_gw_eip" {
    domain = "vpc"
    tags = {
      Name = "nat-gw-eip-tf"
    }
}
#Creating a NAT Gateway using Terraform
resource "aws_nat_gateway" "nat_gw" {
    allocation_id = aws_eip.nat_gw_eip.id
    subnet_id = aws_subnet.public_subnet_1.id
    tags = {
      Name = "nat-gw-tf"
    }
}

#Creating a Route Table for public subnets using Terraform
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.vpc_identifier.id
    tags = {
      Name = "public-rt-tf"
    }
}
#Adding route to route_table for Internet Gateway using Terraform
resource "aws_route" "public_rt_internet" {
    route_table_id = aws_route_table.public_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
}
#Associating the public subnets with the public Route Table using Terraform
resource "aws_route_table_association" "public_subnet-association" {
    subnet_id = aws_subnet.public_subnet_1.id
    route_table_id = aws_route_table.public_rt.id
}
#Done for public route table

#Creating a Route Table for private subnets using Terraform
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc_identifier.id
  tags = {
    Name = "private-rt-tf"
  }
}
#Adding route to route_table for NAT Gateway using Terraform
resource "aws_route" "private_rt_nat" {
  route_table_id = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gw.id
}
#Associating both the private subnets with the private Route Table using Terraform
resource "aws_route_table_association" "private_subnet_1-association" {
  subnet_id = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_rt.id
}
resource "aws_route_table_association" "private_subnet_2-association" {
  subnet_id = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_rt.id
}
#private route table is done

#Creating a security group for bastion host using Terraform
resource "aws_security_group" "bastion_sg" {
  description = "allow ssh access to bastion host"
  vpc_id = aws_vpc.vpc_identifier.id
  ingress {
      from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "bastion-sg-tf"
  }

}

#creating ec2 instance in public subnet using Terraform
resource "aws_instance" "bastion_ec2" {
    ami = "ami-02dfbd4ff395f2a1b" #Amazon Linux 2 AMI (HVM), SSD Volume Type
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public_subnet_1.id
    availability_zone = "us-east-1a"
    security_groups = [aws_security_group.bastion_sg.id]
  tags = {
    Name = "bastion-ec2"
  }
}

#Creating a security group for private instances using Terraform
resource "aws_security_group" "private_sg" {
  description = "allow ssh access to private instances from bastion host"
  vpc_id = aws_vpc.vpc_identifier.id
  ingress {
      from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "private-sg-tf"
  }

}
#creating ec2 instance in private subnet using Terraform
resource "aws_instance" "app_ec2" {
    ami = "ami-02dfbd4ff395f2a1b" #Amazon Linux 2 AMI (HVM), SSD Volume Type
    instance_type = "t2.micro"
    subnet_id = aws_subnet.private_subnet_1.id
    availability_zone = "us-east-1a"
    security_groups = [aws_security_group.private_sg.id]
  tags = {
    Name = "app-ec2"
  }
}    