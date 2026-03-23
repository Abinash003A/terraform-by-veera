resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "Abby-VPC"
    }

#without lifecycle rule 
#only focus on block where rule is written
# 1st destroy resource and then create replacement (when create_before_destroy=true)
#without this terraform will 1st destroy and then create resource by default
#     lifecycle {
#     create_before_destroy = true
# }

#2nd ignore changes
#without this rule terraform can find the change in console that we made manually or any way
#adding tags to ignore block ignores the chamges when tf compares current and desiired state
    # lifecycle {
    #   ignore_changes = [tags]
    # }


    #3rd prevent destroy
    #without this rule terraform can destroy the resource
    #adding prevent_destroy to true prevents terraform from destroying the resource
  #   lifecycle {
  #     prevent_destroy = true
  #   }
}



# resource "aws_s3_bucket" "this" {
#     bucket = "abby-bucket-23-march-2026"
#     tags = {
#       Name = "Abby-Bucket-23-march-2026"
#     } 
# }

