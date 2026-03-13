terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket-day-5"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
