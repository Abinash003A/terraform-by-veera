 #create a s3 bucket to store lambda code
 resource "aws_s3_bucket" "bucket" {
  bucket = "veera-lambda-s3-code"    

   
 }
 #create an IAM role for lambda function
 #create a policy for lambda function
 #attach the policy to the role
 #create a lambda function with s3 bucket as source code
 #