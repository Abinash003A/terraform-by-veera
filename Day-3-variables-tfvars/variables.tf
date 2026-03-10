variable "prod_ami_id" {
  description = "AMI ID for prod environment"
  type        = string
}

variable "test_ami_id" {
  description = "AMI ID for test environment"
  type        = string
}           
variable "prod_instance_type" {
  description = "EC2 instance type for prod environment"
  type        = string
}
variable "test_instance_type" {
  description = "EC2 instance type for test environment"
  type        = string
}