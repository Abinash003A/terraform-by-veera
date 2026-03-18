resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "dev-vpc"
    }
    depends_on = [aws_s3_bucket.name]
}
resource "aws_s3_bucket" "name" {
    bucket = "abinash-bucket-terraform-8080"
}
#the dependency will be created 1st , then the vpc will be created. 
#if we remove the dependency then the vpc will be created 1st and then the bucket will be created. 
#but in this case we want to create the bucket 1st and then the vpc. 
#so we have to use the depends_on argument to create the dependency between the resources.