terraform {
  backend "s3" {
    bucket = "my-terraform-state-locking-134"
    key    = "day-6/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-state-lock-dynamo" #use partition key = LockID and sort key = LockID

    #use_lockfile = true
    #dynmodb no longer required for state locking in s3 backend we can use lockfile for state locking in s3 backend
    #Enable s3 native state locking using lockfile for state locking in s3 backend
    #terraform version shouid be 1.10 above to use lockfile for state locking in s3 backend
  }
}