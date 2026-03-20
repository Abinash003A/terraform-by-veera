module "root_module" {
  source = "github.com/Abinash003A/terraform-by-veera/day-11-module-file-in-git"
  
  vpc_cidr_block = "10.0.0.0/16"

  subnet_cidr_block = {
    "subnet1_cidr_block" = "10.0.1.0/24"
    "subnet2_cidr_block" = "10.0.2.0/24"
  }

  tags = {
    vpc_tags = {
      Name = "my-vpc"
    }
    subnet1_tags = {
      Name = "my-subnet-1"
    }
    subnet2_tags = {
      Name = "my-subnet-2"
    }
  }

  availability_zone = {
    "subnet1_az" = "us-east-1a"
    "subnet2_az" = "us-east-1b"
  }


}
