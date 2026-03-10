provider "aws" {
     alias   = "prod"
  profile = "prod-user"
  region  = "us-east-1"
}
provider "aws" {
     alias   = "test"
  profile = "test-user"
  region  = "us-west-2"
}