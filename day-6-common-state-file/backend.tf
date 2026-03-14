terraform {
  backend "s3" {
    bucket = "my-terraform-state-locking-13"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}