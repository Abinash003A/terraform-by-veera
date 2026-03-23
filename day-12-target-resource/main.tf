resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "Abby-VPC-2"
    }
  
}
resource "aws_s3_bucket" "this" {
    bucket = "abby-bucket-23-march-2026-2"
    tags = {
      Name = "Abby-Bucket-23-march-2026-2-22"
    } 
}

#only targeted resource will be created
#terraform plan -target=aws_vpc.name

#we can use multi target also
#terraform plan -target=aws_vpc.name -target=aws_s3_bucket.this